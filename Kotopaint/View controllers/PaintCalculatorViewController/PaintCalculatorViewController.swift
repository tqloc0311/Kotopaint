//
//  PaintCalculatorViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PaintCalculatorViewController: BackButtonViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    private var numOfLayers = 1 {
        didSet {
            numOfLayerLabel.text = numOfLayers.toString()
        }
    }
    
    private var step2SelectedIndex = 0 {
        didSet {
            switch step2SelectedIndex {
            case 0:
                step2Part1View.isHidden = false
                step2Part2View.isHidden = true
            case 1:
                step2Part1View.isHidden = true
                step2Part2View.isHidden = false
            default:
                break
            }
        }
    }
    
    private var categories = [Category]()
    private var dataSource: [Category: [Product]] = [:]
    private var isLoading = false {
        didSet {
            indicator.isHidden = !isLoading
            tableView.isHidden = isLoading
            step1Segment.isEnabled = !isLoading
        }
    }
    
    var selectedProducts: [Category: Product?] = [:]
    
    //  MARK: - Outlets
    @IBOutlet weak var boxStep1View: UIView!
    @IBOutlet weak var step1Segment: UISegmentedControl!
    @IBOutlet weak var numOfLayerLabel: UILabel!
    @IBOutlet weak var layerStepper: UIStepper!
    
    @IBOutlet weak var boxStep2View: UIView!
    @IBOutlet weak var step2Segment: UISegmentedControl!
    @IBOutlet weak var step2Part1View: UIView!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var step2Part2View: UIView!
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var numOfFloorTextField: UITextField!
    
    @IBOutlet weak var boxStep3View: UIView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    //  MARK: - Actions
    @IBAction func changeStepperValue(_ sender: Any) {
        numOfLayers = Int(layerStepper.value)
    }
    
    @IBAction func changeStep1Segment(_ sender: Any) {
        if !isLoading {
            loadData()
        }
    }
    
    @IBAction func changeStep2Segment(_ sender: Any) {
        step2SelectedIndex = step2Segment.selectedSegmentIndex
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
        
        let borderColor = UIColor(hexString: "EBECEB")!
        boxStep1View.setBorder(color: borderColor, width: 1, corner: 10)
        boxStep1View.backgroundColor = .clear
        boxStep2View.setBorder(color: borderColor, width: 1, corner: 10)
        boxStep2View.backgroundColor = .clear
        
        step2SelectedIndex = 0
        
        boxStep3View.setBorder(color: borderColor, width: 1, corner: 10)
        boxStep3View.backgroundColor = .clear
        
        indicator.startAnimating()
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(nibName: CheckProductTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 120
        
        tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    private func validate() -> Bool {
        self.view.endEditing(true)
        if selectedProducts.count == 0 {
            showErrorAlert(title: "Lỗi", subtitle: "Vui lòng chọn ít nhất một sản phẩm ở Bước 3", buttonTitle: "Thử lại")
            return false
        }
        else {
            if step2Segment.selectedSegmentIndex == 0 {
                if areaTextField.text == "" {
                    showErrorAlert(title: "Lỗi", subtitle: "Vui lòng nhập tổng diện tích", buttonTitle: "Thử lại")
                    return false
                }
            }
            else {
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
                else if numOfFloorTextField.text == "" {
                    showErrorAlert(title: "Lỗi", subtitle: "Vui lòng nhập số tầng", buttonTitle: "Thử lại")
                    return false
                }
            }
        }
        return true
    }
    
    func calculate() {
        if validate() {
            let item = PaintCalculator()
            item.construct = PaintCalculator.Construct(rawValue: step1Segment.selectedSegmentIndex)!
            item.layout = Int(layerStepper.value)
            item.step2Mode = PaintCalculator.Step2Mode(rawValue: step2Segment.selectedSegmentIndex)!
            if item.step2Mode == .total {
                item.area = Int(areaTextField.text ?? "1") ?? 1
            }
            else {
                item.long = Int(longTextField.text ?? "1") ?? 1
                item.height = Int(heightTextField.text ?? "1") ?? 1
                item.width = Int(widthTextField.text ?? "1") ?? 1
                item.floor = Int(numOfFloorTextField.text ?? "1") ?? 1
            }
            
            item.products = selectedProducts.compactMap({ $0.value })
            
            showWaiting()
            PaintCalculatorRepository.shared.calculate(item) { [unowned self] (errorMsg, result) in
                hideWaiting()
                
                if errorMsg != "" {
                    self.showErrorAlert(title: "Lỗi", subtitle: errorMsg, buttonTitle: "Thử lại")
                }
                else if let result = result {
                    let vc = PaintCalculatorDetailViewController(nibName: nil, bundle: nil, result: result)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else {
                    self.showErrorAlert(title: "Lỗi", subtitle: "Unknown error", buttonTitle: "Thử lại")
                }
            }
        }
    }
    
    func loadData() {
        var categoryId = Globals.NOITHAT_CATEGORY_ID
        if step1Segment.selectedSegmentIndex == 1 {
            categoryId = Globals.NGOAITHAT_CATEGORY_ID
        }
        
        isLoading = true
        CategoryRepository.shared.getChildCategoryOf(categoryId: categoryId) { [unowned self] (categories) in
            self.categories = categories
            ProductRepository.shared.loadData(categoryArray: categories.map({ $0.id }), completion: { [unowned self] (result) in
                
                self.dataSource.removeAll()
                self.selectedProducts.removeAll()
                for item in categories {
                    self.selectedProducts[item] = nil
                }
                
                for cate in categories {
                    var products = [Product]()
                    
                    for p in result {
                        if p.categoryId == cate.id {
                            products.append(p)
                        }
                    }
                    
                    self.dataSource[cate] = products
                }
                
                self.tableView.reloadData() {
                    self.isLoading = false
                }
                
            })
            
        }
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Phần mềm tính sơn"
        setupView()
        configTableView()
        
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tableView.removeObserver(self, forKeyPath: "contentSize")
        super.viewWillDisappear(true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
                tableViewHeightConstraint.constant = newsize.height
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
}

// MARK: - UIGestureRecognizerDelegate
extension PaintCalculatorViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension PaintCalculatorViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if dataSource.count > 0 {
            return dataSource.count
        }
        else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if categories.count > 0, let count = dataSource[categories[section]]?.count {
            return count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataSource.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Không có dữ liệu"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(CheckProductTableViewCell.self)
            
            guard let item = dataSource[categories[indexPath.section]]?[indexPath.row] else { return UITableViewCell() }
            let selected = selectedProducts.compactMap({ $0.value })
            cell.configure(data: item)
            cell.checked = selected.contains(item)
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if categories.count == 0 || categories.count <= section {
            return nil
        }
        return categories[section].title
    }
}

// MARK: - UITableViewDelegate
extension PaintCalculatorViewController: UITableViewDelegate {
    
}

// MARK: - CheckProductTableViewCellDelegate
extension PaintCalculatorViewController: CheckProductTableViewCellDelegate {
    func selectProduct(product: Product) {
        if let cate = categories.first(where: { $0.id == product.categoryId }) {
            selectedProducts[cate] = product
            tableView.reloadData()
        }
    }
}
