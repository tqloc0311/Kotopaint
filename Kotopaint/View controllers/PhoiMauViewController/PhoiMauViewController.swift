//
//  PhoiMauViewController.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/27/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import AMPopTip

class PhoiMauViewController: BackButtonViewController {

    //  MARK: - Constants
    
    //  MARK: - Properties
    var phoimauItem: PhoiMauItem!
    private var popTip = PopTip()
    private var colorGalleries = ColorGalleryRepository.shared.storage
    private var selectedColors = [ColorItem]()
    private var selectedColorIndex = 0
    private var savedImages = [PhoiMauResult]() {
        didSet {
            if let last = savedImages.last?.image {
                savedImageView.image = last
                savedImageView.isEnabled = true
            }
        }
    }
    
    //  MARK: - Outlets
    @IBOutlet weak var imagesContainerView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet var maskImageViews: [UIImageView]!
    @IBOutlet weak var colorCategoryCollectionView: UICollectionView!
    @IBOutlet weak var selectColorView: UIView!
    @IBOutlet weak var savedImageView: ImageButton!
    @IBOutlet var colorSelectingButtons: [ViewButton]!
    
    //  MARK: - Actions
    @IBAction func goHome(_ sender: Any) {
        popTip.hide()
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func save(_ sender: Any) {
        popTip.hide()
        showWaiting()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            guard let image = self.imagesContainerView.asImage() else {
                self.showErrorAlert(title: "Lỗi", subtitle: "Không thể lưu hình này", buttonTitle: "Thử lại")
                return
            }
            let resultItem = PhoiMauResult(image: image, selectedItems: self.selectedColors)
            PhoiMauResultRepository.shared.save(item: resultItem)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.savedImages.append(resultItem)
                hideWaiting()
            }
        }
        
    }
    
    @IBAction func reset(_ sender: Any) {
        popTip.hide()
        selectedColors = Array(repeating: ColorItem(), count: 5)
        updateImages()
    }
    
    //  MARK: - Methods
    func setupView() {
        
        let panGesture = UIPanGestureRecognizer { [weak self] (recognizer) in
            guard let self = self else { return }
            if let panGesture = recognizer as? UIPanGestureRecognizer, let isRight = panGesture.isLeftToRight(self.view), isRight {
//                self.didBack()
            }
        }
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
        
        setupPoptip()
        
        selectColorView.setBorder(color: .lightGray, width: 1, corner: 0)
        for button in colorSelectingButtons {
            button.setBorder(color: .lightGray, width: 1, corner: 0)
            button.backgroundColor = .white
            button.touchUpInsideAction = { [weak self] in
                guard let self = self else { return }
                self.didTapSelectColorButton(index: button.tag)
            }
        }
        
        colorSelectingButtons[0].setBorder(color: .blue, width: 1, corner: 0)
        savedImageView.setBorder(color: .lightGray, width: 1, corner: 0)
        
        savedImageView.touchUpInsideAction = didTapSavedImageView
        savedImageView.isEnabled = false
    }
    
    func highlightSelectColorButton(index: Int) {
        for btn in colorSelectingButtons {
            if btn.tag == index {
                btn.setBorder(color: .blue, width: 1, corner: 0)
            }
            else {
                btn.setBorder(color: .lightGray, width: 1, corner: 0)
            }
        }
    }
    
    func didTapSelectColorButton(index: Int) {
        popTip.hide()
        selectedColorIndex = index
        highlightSelectColorButton(index: index)
    }
    
    func updateImages() {
        for (index, imgv) in maskImageViews.enumerated() {
            imgv.setImageColor(color: selectedColors[index].color)
        }
    }
    
    func didTapSavedImageView() {
        let vc = PhoiMauResultViewController(nibName: nil, bundle: nil, resultList: savedImages)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupCollectionView() {
        colorCategoryCollectionView.delegate = self
        colorCategoryCollectionView.dataSource = self
        
        colorCategoryCollectionView.register(nibName: PhoiMauColorGalleryCell.self)
    }
    
    func showPopTip(at index: Int, selectedColorItem: ColorItem? = nil) {
        let imageRatio: CGFloat = 3/4
        
        guard
            let palleteView = UIView.loadFromNibNamed("ColorPaletteView") as? ColorPaletteView,
            let cell = colorCategoryCollectionView.cellForItem(at: IndexPath(item: index, section: 0))
            else {
                return
        }
        palleteView.loadData(data: colorGalleries[index].colorItems.compactMap({ $0 }), at: selectedColorIndex, with: selectedColorItem)
        palleteView.delegate = self
        let padding: CGFloat =  4
        let popTipWidth = colorCategoryCollectionView.bounds.width - 28
        let colorItemWidth = (popTipWidth - padding * 8) / 9
        let colorItemHeight = (colorItemWidth * imageRatio)
        let popTipHeight = colorItemHeight * 3 + padding * 7
        palleteView.frame = CGRect(x: 0, y: 0, width: popTipWidth, height: popTipHeight)
        let rect = self.view.convert(cell.frame, from: colorCategoryCollectionView)
        popTip.show(customView: palleteView, direction: .down, in: self.view, from: rect)
    }
    
    func selectGalleryAt(index: Int) {
        showPopTip(at: index, selectedColorItem: selectedColors[selectedColorIndex])
    }
    
    func setupPoptip() {
        popTip.shouldDismissOnTap = false
        popTip.shouldDismissOnTapOutside = true
        popTip.edgeMargin = 8
        popTip.offset = -4
        popTip.bubbleOffset = 0
        popTip.edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        popTip.cornerRadius = 10
        popTip.dropShadow(cornerRadius: 10)
        popTip.bubbleColor = .white
        popTip.borderWidth = 1
        popTip.borderColor = .lightGray
        popTip.entranceAnimation = .fadeIn
    }
    
    func configure() {
        mainImageView.image = phoimauItem.image
        for (index, item) in phoimauItem.masks.enumerated() {
            maskImageViews[index].image = item.image
            maskImageViews[index].setImageColor(color: .clear)
        }
        
        loadColorGallery()
        for button in colorSelectingButtons {
            if button.tag >= phoimauItem.masks.count {
                button.isHidden = true
            }
        }
        
        selectedColors = Array(repeating: ColorItem(), count: 5)
        loadSavedPhoiMau()
    }
    
    func loadSavedPhoiMau() {
        savedImages = PhoiMauResultRepository.shared.loadData()
    }
    
    func loadColorGallery() {
        showWaiting()
        ColorGalleryRepository.shared.loadData { [weak self] (error, result) in
            guard let self = self else { return }
            hideWaiting()
            if error != "" {
                self.showErrorAlert(title: "Lỗi", subtitle: error, buttonTitle: "Thử lại")
            }
            else {
                self.colorGalleries = result
                self.colorCategoryCollectionView.reloadData()
            }
        }
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, phoimauItem: PhoiMauItem) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.phoimauItem = phoimauItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tự phối màu"
        setupView()
        setupCollectionView()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension PhoiMauViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension PhoiMauViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorGalleries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PhoiMauColorGalleryCell.self, indexPath: indexPath)
        
        let item = colorGalleries[indexPath.item]
        cell.configure(item)
        cell.selectAction = { [weak self] in
            guard let self = self else { return }
            self.selectGalleryAt(index: indexPath.item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  4
        let height = collectionView.frame.size.height - (padding * 2)
        
        let imageRatio: CGFloat = 4/5
        let width = height / imageRatio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        popTip.hide(forced: true)
    }
}

extension PhoiMauViewController: ColorPaletteDelegate {
    func colorPaletteDidSelect(_ colorItem: ColorItem, at index: Int) {
        selectedColors[index] = colorItem
        updateImages()
    }
    
}
