//
//  PaintCalculatorDetailV2ViewController.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 1/11/19.
//  Copyright © 2019 Stage Group. All rights reserved.
//

import UIKit

class PaintCalculatorDetailV2ViewController: BackButtonViewController {

    //  MARK: - Constants
    
    //  MARK: - Properties
    var result: PaintCalculatorResultV2!
    var items: [PaintCalculatorResultItemV2] {
        return result.items
    }
    
    //  MARK: - Outlets
    @IBOutlet weak var acreageExLabel: UILabel! {
        didSet {
            acreageExLabel.text = "1m²"
        }
    }
    @IBOutlet weak var acreageWaterLabel: UILabel! {
        didSet {
            acreageWaterLabel.text = "1m²"
        }
    }
    @IBOutlet weak var acreageFuLabel: UILabel! {
        didSet {
            acreageFuLabel.text = "4m²"
        }
    }
    @IBOutlet weak var acreageFulLabel: UILabel! {
        didSet {
            acreageFulLabel.text = "5m²"
        }
    }
    @IBOutlet weak var acreageCeLabel: UILabel! {
        didSet {
            acreageCeLabel.text = "1m²"
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(nibName: PaintCalculatorResultV2TableViewCell.self)
            tableView.tableFooterView = UIView()
        }
    }
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    func setupView() {
        
        let panGesture = UIPanGestureRecognizer { (recognizer) in
            if let panGesture = recognizer as? UIPanGestureRecognizer, let isRight = panGesture.isLeftToRight(self.view), isRight {
                self.didBack()
            }
        }
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
    }
    
    private func configure() {
        acreageExLabel.text = "\(result.acreageEx)m²"
        acreageWaterLabel.text = "\(result.acreageWater)m²"
        acreageFuLabel.text = "\(result.acreageFu)m²"
        acreageFulLabel.text = "\(result.acreageFul)m²"
        acreageCeLabel.text = "\(result.acreageCe)m²"
        tableView.reloadData()
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, result: PaintCalculatorResultV2) {
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
extension PaintCalculatorDetailV2ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension PaintCalculatorDetailV2ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if items.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Không có dữ liệu"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(PaintCalculatorResultV2TableViewCell.self)
            
            let item = items[indexPath.row]
            cell.configure(data: item)
            return cell
        }
        
    }
}

// MARK: - UITableViewDelegate
extension PaintCalculatorDetailV2ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        showWaiting()
        ProductRepository.shared.getBy(productID: item.id) { [unowned self] (errorMsg, product) in
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
