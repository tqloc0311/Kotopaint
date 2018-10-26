//
//  ProductViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/24/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class ProductViewController: BackButtonViewController {

    //  MARK: - Constants
    
    //  MARK: - Properties
    var dataSource = [Product]()
    private var category: Category!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = DEFAULT_COLOR
        
        return refreshControl
    }()
    
    //  MARK: - Outlets
    @IBOutlet weak var tableView: SDStateTableView!
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    func setupView() {
        
        let panGesture = UIPanGestureRecognizer { [weak self]  (recognizer) in
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
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(nibName: ProductCell.self)
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl)
        tableView.rowHeight = 120
    }
    
    func loadData(completion: (()->())? = nil) {
        showWaiting()
        ProductRepository.shared.loadData(categoryID: category.id) { [weak self]  (result) in
            hideWaiting()
            guard let self = self else { return }
            if result.count == 0 {
                self.tableView.setState(.withImage(image: nil, title: "Không có dữ liệu", message: ""))
            }
            else {
                self.tableView.setState(.dataAvailable)
                self.dataSource = result
                self.tableView.reloadData()
            }
            
            completion?()
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        loadData() {
            refreshControl.endRefreshing()
        }
        
    }
    
    func selectCell(_ cell: ProductCell, at indexPath: IndexPath) {
        let selected = dataSource[indexPath.row]
        let vc = ProductDetailViewController(nibName: nil, bundle: nil, product: selected)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configure(category: Category) {
        self.navigationItem.title = category.title
        
        loadData()
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, category: Category) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.category = category
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configTableView()
        configure(category: category)
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ProductViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        return dataSource.count == 0 ? 0 : dataSource.count + 1
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(ProductCell.self)
        let item = dataSource[indexPath.row]
        cell.configure(data: item)
        cell.selectAction = {
            self.selectCell(cell, at: indexPath)
        }
        cell.panAction = { [weak self] isRight in
            guard let self = self else { return }
            if isRight {
                self.didBack()
            }
            else {
                self.selectCell(cell, at: indexPath)
            }
        }
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension ProductViewController: UITableViewDelegate {
    
}
