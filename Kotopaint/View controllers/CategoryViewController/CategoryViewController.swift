//
//  CategoryViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class CategoryViewController: SideMenuViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    var dataSource = [Category]()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = DEFAULT_COLOR
        
        return refreshControl
    }()
    
    //  MARK: - Outlets
    @IBOutlet weak var backButton: ImageButton!
    @IBOutlet weak var tableView: SDStateTableView!
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    func setupView() {
        backButton.touchUpInsideAction = {
            self.back()
        }
        
        let panGesture = UIPanGestureRecognizer { (recognizer) in
            if let panGesture = recognizer as? UIPanGestureRecognizer, let isRight = panGesture.isRight(self.view), isRight {
                self.back()
            }
        }
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
    }
    
    func back() {
        self.tabBarController?.selectedIndex = 0
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(nibName: AllCategoryCell.self)
        tableView.register(nibName: CategoryCell.self)
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl)
        tableView.rowHeight = 120
    }
    
    func loadData(completion: (()->())? = nil) {
        showWaiting()
        CategoryRepository.shared.loadData { (result) in
            hideWaiting()
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
    
    func selectCell(_ cell: CategoryCell, at indexPath: IndexPath) {
//        showWaiting()
        let selected = dataSource[indexPath.row]
//        self.selectedCategory = selected
//        self.productRepo.getBy(categoryId: selected.id) { (result) in
//            hideWaiting()
//            cell.highlight(false)
//            self.productsByCategory = result
//            self.performSegue(withIdentifier: "showProduct", sender: nil)
//        }
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configTableView()
        loadData()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension CategoryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return dataSource.count == 0 ? 0 : dataSource.count + 1
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(AllCategoryCell.self)
//            return cell
//        }
//        else {
//            let cell = tableView.dequeueReusableCell(CategoryCell.self)
//            let item = dataSource[indexPath.row - 1]
//            cell.configure(data: item)
//            cell.selectAction = {
//                self.selectCell(cell, at: indexPath)
//            }
//            cell.panAction = { isRight in
//                if isRight {
//                    self.back()
//                }
//                else {
//                    self.selectCell(cell, at: indexPath)
//                }
//            }
//            return cell
//        }
        
        let cell = tableView.dequeueReusableCell(CategoryCell.self)
        let item = dataSource[indexPath.row]
        cell.configure(data: item)
        cell.selectAction = {
            self.selectCell(cell, at: indexPath)
        }
        cell.panAction = { isRight in
            if isRight {
                self.back()
            }
            else {
                self.selectCell(cell, at: indexPath)
            }
        }
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    
}
