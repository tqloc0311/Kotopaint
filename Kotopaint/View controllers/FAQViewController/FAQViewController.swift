//
//  FAQViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/23/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import LUExpandableTableView

class FAQViewController: BackButtonViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    var dataSource = [FaqItem]()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = DEFAULT_COLOR
        
        return refreshControl
    }()
    
    //  MARK: - Outlets
    @IBOutlet weak var expandableTableView: LUExpandableTableView!
    
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
        expandableTableView.expandableTableViewDataSource = self
        expandableTableView.expandableTableViewDelegate = self
        
        expandableTableView.registerForHeaderFooter(nibName: QuestionTableViewCell.self)
        expandableTableView.register(nibName: AnswerTableViewCell.self)
        expandableTableView.tableFooterView = UIView()
        expandableTableView.addSubview(refreshControl)
    }
    
    func loadData(completion: (()->())? = nil) {
        showWaiting()
        FaqRepository.shared.loadData { [weak self] (result) in
            guard let self = self else { return }
            hideWaiting()
            self.dataSource = result
            self.expandableTableView.reloadData()
            
            completion?()
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        loadData() {
            refreshControl.endRefreshing()
        }
        
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Câu hỏi thường gặp"
        
        setupView()
        configTableView()
        loadData()
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
extension FAQViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension FAQViewController: LUExpandableTableViewDataSource {
    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
        return dataSource.count
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandableTableView.dequeueReusableCell(AnswerTableViewCell.self)
        
        cell.configure(answer: dataSource[indexPath.section].answer)
        
        return cell
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, sectionHeaderOfSection section: Int) -> LUExpandableTableViewSectionHeader {
        let sectionHeader = expandableTableView.dequeueHeaderFooterReusableCell(QuestionTableViewCell.self)
        
        sectionHeader.configure(question: dataSource[section].question)
        
        return sectionHeader
    }
}

// MARK: - LUExpandableTableViewDelegate

extension FAQViewController: LUExpandableTableViewDelegate {
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
