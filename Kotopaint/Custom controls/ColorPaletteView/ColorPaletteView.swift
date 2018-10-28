//
//  ColorPaletteView.swift
//  Kotopaint
//
//  Created by ProStageVN on 2/7/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import UIKit

protocol ColorPaletteDelegate {
    func colorPaletteDidSelect(_ colorItem: ColorItem, at index: Int)
}

class ColorPaletteView: UIView {
    
    // Constants

    // MARK: - Properties
    private var colorData = [ColorItem]()
    private var selected: ColorItem?
    private var index = 0
    var delegate: ColorPaletteDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Methods
    
    func loadData(data: [ColorItem], at index: Int, with selectedColorItem: ColorItem? = nil) {
        colorData = data
        self.selected = selectedColorItem
        self.index = index
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        if collectionView == nil {return}
        collectionView.register(UINib(nibName: String(describing: ColorPalleteCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ColorPalleteCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.delaysContentTouches = false
        for view in collectionView.subviews {
            if view is UIScrollView {
                (view as! UIScrollView).delaysContentTouches = false
                break
            }
        }
    }
    
    // Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}

extension ColorPaletteView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorPalleteCell.self), for: indexPath) as? ColorPalleteCell else {return UICollectionViewCell()}
        let item = colorData[indexPath.item]
        cell.backgroundColor = item.color
        if let selected = selected {
            if selected.name == item.name {
                cell.setBorder(color: .blue, width: 2, corner: 0)
            }
            else {
                cell.setBorder(color: .clear, width: 0, corner: 0)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  4
        let collectionViewSize = collectionView.frame.size.width - padding * 8
        let width = collectionViewSize / 9
        return CGSize(width: width, height: width * IMAGE_RATIO)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = colorData[indexPath.item]
        selected = item
        collectionView.reloadData()
        delegate?.colorPaletteDidSelect(item, at: index)
    }
}
