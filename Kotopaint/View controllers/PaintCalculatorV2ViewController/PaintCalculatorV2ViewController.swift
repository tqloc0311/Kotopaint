//
//  PaintCalculatorV2ViewController.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 1/10/19.
//  Copyright © 2019 Stage Group. All rights reserved.
//

import UIKit

class PaintCalculatorV2ViewController: BackButtonViewController {

    // MARK: - Outlets
    @IBOutlet var boxViews: [UIView]! {
        didSet {
            let borderColor = UIColor(hexString: "EBECEB")!
            boxViews.forEach {
                
                $0.setBorder(color: borderColor, width: 1, corner: 10)
                $0.backgroundColor = .clear
            }
        }
    }
    @IBOutlet weak var longTextField: UITextField! {
        didSet {
            longTextField.delegate = self
        }
    }
    @IBOutlet weak var widthTextField: UITextField! {
        didSet {
            widthTextField.delegate = self
        }
    }
    @IBOutlet weak var heightTextField: UITextField! {
        didSet {
            heightTextField.delegate = self
        }
    }
    @IBOutlet weak var numOfFloorsTextField: UITextField! {
        didSet {
            numOfFloorsTextField.delegate = self
        }
    }
    @IBOutlet weak var numOfColorSurfacesTextField: UITextField! {
        didSet {
            numOfColorSurfacesTextField.delegate = self
        }
    }
    @IBOutlet weak var numOfWaterproofingSurfacesTextField: UITextField! {
        didSet {
            numOfWaterproofingSurfacesTextField.delegate = self
        }
    }
    @IBOutlet weak var productTableView: UITableView! {
        didSet {
            productTableView.delegate = self
            productTableView.dataSource = self
            
            productTableView.register(nibName: PaintCalculatorV2TableViewCell.self)
            productTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var productTableViewHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    var dataSource: [PaintCalculatorCategory] = PaintCalculatorRepository.shared.categories
    var selectedProducts: [PaintCalculatorProduct] = []
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Phần mềm tính sơn"
        setupView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        productTableView.removeObserver(self, forKeyPath: "contentSize")
        super.viewWillDisappear(animated)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
                productTableViewHeight.constant = newsize.height
            }
        }
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        if let tabBarVC = self.tabBarController {
            tabBarVC.selectedIndex = 0
        }
        else if let revealVC = self.revealViewController() as? CustomRevealViewController {
            revealVC.pushFrontViewController(revealVC.tabBarVC, animated: true)
            revealVC.tabBarVC.selectedIndex = 0
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //  MARK: - Methods
    func setupView() {
        
        let rightButton = UIBarButtonItem(title: "Tính sơn") {
            [weak self] in
            guard let self = self else { return }
            self.calculate()
        }
        
        self.navigationItem.rightBarButtonItem = rightButton
        
        let panGesture = UIPanGestureRecognizer { (recognizer) in
            if let panGesture = recognizer as? UIPanGestureRecognizer, let isRight = panGesture.isLeftToRight(self.view), isRight {
                self.didBack()
            }
        }
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
    }
    
    func validate() -> Bool {
        if longTextField.text == "" {
            showErrorAlert(title: "Lỗi", subtitle: "Vui lòng nhập chiều dài (m)", buttonTitle: "Thử lại")
            return false
        }
        else if widthTextField.text == "" {
            showErrorAlert(title: "Lỗi", subtitle: "Vui lòng nhập chiều rộng (m)", buttonTitle: "Thử lại")
            return false
        }
        else if heightTextField.text == "" {
            showErrorAlert(title: "Lỗi", subtitle: "Vui lòng nhập chiều cao (m)", buttonTitle: "Thử lại")
            return false
        }
        else if numOfFloorsTextField.text == "" {
            showErrorAlert(title: "Lỗi", subtitle: "Vui lòng nhập số tầng", buttonTitle: "Thử lại")
            return false
        }
        else if numOfColorSurfacesTextField.text == "" {
            showErrorAlert(title: "Lỗi", subtitle: "Vui lòng nhập số mặt cần sơn màu", buttonTitle: "Thử lại")
            return false
        }
        else if numOfWaterproofingSurfacesTextField.text == "" {
            showErrorAlert(title: "Lỗi", subtitle: "Vui lòng nhập số mặt cần sơn chống thấm", buttonTitle: "Thử lại")
            return false
        }
        else if selectedProducts.count == 0 {
            showErrorAlert(title: "Lỗi", subtitle: "Vui lòng chọn ít nhất một sản phẩm", buttonTitle: "Thử lại")
            return false
        }
        return true
    }
    
    func calculate() {
        if validate() {
            guard
                let long = Int(longTextField.text ?? ""),
                let width = Int(widthTextField.text ?? ""),
                let height = Int(heightTextField.text ?? ""),
                let numOfFloors = Int(numOfFloorsTextField.text ?? ""),
                let numOfColorSurfaces = Int(numOfColorSurfacesTextField.text ?? ""),
                let numOfWaterproofingSurfaces = Int(numOfWaterproofingSurfacesTextField.text ?? ""),
                selectedProducts.count > 0
            else { return }
            
            showWaiting()
            PaintCalculatorRepository.shared.calculateV2(long: long, width: width, height: height, numOfFloors: numOfFloors, colorSurfaces: numOfColorSurfaces, waterproofingSurfaces: numOfWaterproofingSurfaces, products: selectedProducts) { [weak self] (errorMsg, result) in
                guard let self = self else { return }
                hideWaiting()
                
                if errorMsg != "" {
                    self.showErrorAlert(title: "Lỗi", subtitle: errorMsg, buttonTitle: "Thử lại")
                }
                else if let result = result {
                    let vc = PaintCalculatorDetailV2ViewController(nibName: nil, bundle: nil, result: result)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else {
                    self.showErrorAlert(title: "Lỗi", subtitle: "Unknown error", buttonTitle: "Thử lại")
                }

            }
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension PaintCalculatorV2ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension PaintCalculatorV2ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataSource.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Không có dữ liệu"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(PaintCalculatorV2TableViewCell.self)
            
            let item = dataSource[indexPath.row]
            cell.configure(item)
            cell.delegate = self
            return cell
        }
        
    }
}

// MARK: - UITableViewDelegate
extension PaintCalculatorV2ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - PaintCalculatorV2TableViewCellDelegate
extension PaintCalculatorV2ViewController: PaintCalculatorV2TableViewCellDelegate {
    func paintCalculatorV2TableViewCellDelegate(_ cell: PaintCalculatorV2TableViewCell, didSelect product: PaintCalculatorProduct?, numOfLayers: Int) {
        guard let product = product else { return }
        if let find = selectedProducts.first(where: { $0.id == product.id }) {
            find.numOfLayers = numOfLayers
        }
        else {
            product.numOfLayers = numOfLayers
            selectedProducts.append(product)
        }
    }
}

// MARK: - UITextFieldDelegate
extension PaintCalculatorV2ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case longTextField:
            widthTextField.becomeFirstResponder()
        case widthTextField:
            heightTextField.becomeFirstResponder()
        case heightTextField:
            numOfFloorsTextField.becomeFirstResponder()
        case numOfFloorsTextField:
            numOfColorSurfacesTextField.becomeFirstResponder()
        case numOfColorSurfacesTextField:
            numOfWaterproofingSurfacesTextField.becomeFirstResponder()
        case numOfWaterproofingSurfacesTextField:
            numOfWaterproofingSurfacesTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
