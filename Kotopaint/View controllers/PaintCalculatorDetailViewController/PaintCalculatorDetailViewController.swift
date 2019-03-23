//
//  PaintCalculatorDetailViewController.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/25/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class PaintCalculatorDetailViewController: BackButtonViewController {

    //  MARK: - Constants
    
    //  MARK: - Properties
    var result: PaintCalculatorResult!
    var items: [PaintCalculatorResultItem] {
        return result.items
    }
    
    //  MARK: - Outlets
    @IBOutlet weak var constructLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    func setupView() {
        
        let panGesture = UIPanGestureRecognizer { [weak self] (recognizer) in
            guard let self = self else { return }
            if let panGesture = recognizer as? UIPanGestureRecognizer, let isRight = panGesture.isLeftToRight(self.view), isRight {
                self.didBack()
            }
        }
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
    }
    
    func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(nibName: PaintCalculatorResultTableViewCell.self)
        tableView.tableFooterView = UIView()
    }
    
    private func configure() {
        constructLabel.text = result.construct
        areaLabel.text = "\(result.area) m²"
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, result: PaintCalculatorResult) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.result = result
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Kết quả tính sơn"
        setupView()
        configTableView()
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
extension PaintCalculatorDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension PaintCalculatorDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if items.count > 0 {
            return items.count
        }
        else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if items.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Không có dữ liệu"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(PaintCalculatorResultTableViewCell.self)
            
            let item = items[indexPath.section]
            cell.configure(data: item)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].categoryTitle
    }
}

// MARK: - UITableViewDelegate
extension PaintCalculatorDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        showWaiting()
        ProductRepository.shared.getBy(productID: item.id) { [weak self] (errorMsg, product) in
            guard let self = self else { return }
            hideWaiting()
            if errorMsg != "" {
                self.showErrorAlert(title: "Lỗi", subtitle: errorMsg, buttonTitle: "Thử lại")
            }
            else if let product = product {
                let vc = ProductDetailViewController(nibName: nil, bundle: nil, product: product)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                self.showErrorAlert(title: "Lỗi", subtitle: "Unknown error", buttonTitle: "Thử lại")
            }
        }
        
    }
}
