//
//  PhoiMauViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import ActionKit

class PhoiMauCategoryViewController: BackButtonViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    var parentCategory: PhoiMauCategory?
    var dataSource = [PhoiMauCategory]()
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
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(nibName: PhoiMauCategoryTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl)
        tableView.rowHeight = 120
    }
    
    func loadData(completion: (()->())? = nil) {
        showWaiting()
        PhoiMauCategoryRepository.shared.loadData { [weak self] (result) in
            hideWaiting()
            guard let self = self else { return }
            var filter = result
            if let parentCategory = self.parentCategory {
                filter.removeAll()
                for item in result {
                    if item.id == parentCategory.id {
                        filter = item.child
                    }
                }
            }
            
            if filter.count == 0 {
                self.tableView.setState(.withImage(image: nil, title: "Không có dữ liệu", message: ""))
            }
            else {
                self.tableView.setState(.dataAvailable)
                self.dataSource = filter
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
    
    func selectCell(_ cell: PhoiMauCategoryTableViewCell, at indexPath: IndexPath) {
        let selected = dataSource[indexPath.row]
        if selected.child.count > 0 {
            let vc = PhoiMauCategoryViewController(nibName: nil, bundle: nil, parentCategory: selected)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = PhoiMauItemViewController(nibName: nil, bundle: nil, phoimauCategory: selected)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, parentCategory: PhoiMauCategory?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.parentCategory = parentCategory
        
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.parentCategory = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Phần mềm phối màu"
        if let cate = parentCategory {
            self.navigationItem.title = cate.name
        }
        
        setupView()
        configTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        if let _ = parentCategory {
            self.navigationController?.popViewController(animated: true)
        }
        else if let tabBarVC = self.tabBarController {
            tabBarVC.selectedIndex = 0
        }
        else if let revealVC = self.revealViewController() as? CustomRevealViewController {
            revealVC.pushFrontViewController(revealVC.tabBarVC, animated: true)
            revealVC.tabBarVC.selectedIndex = 0
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension PhoiMauCategoryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension PhoiMauCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(PhoiMauCategoryTableViewCell.self)
        let item = dataSource[indexPath.row]
        cell.configure(data: item)
        cell.selectAction = { [weak self] in
            guard let self = self else { return }
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
extension PhoiMauCategoryViewController: UITableViewDelegate {
    
}
