//
//  PhoiMauResultViewController.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/28/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class PhoiMauResultViewController: BackButtonViewController {

    //  MARK: - Constants
    
    //  MARK: - Properties
    var dataSource = [PhoiMauResult]()
    
    //  MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
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
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(nibName: PhoiMauResultTableViewCell.self)
        tableView.tableFooterView = UIView()
    }
    
    func selectImage(_ item: PhoiMauResult) {
        let vc = ImageViewerViewController(nibName: nil, bundle: nil, image: item.image, imageViewHeroID: "phoimauResultDetail_\(item.id)")
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, resultList: [PhoiMauResult]) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.dataSource = resultList
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Danh sách đã lưu"
        setupView()
        configTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - UIGestureRecognizerDelegate
extension PhoiMauResultViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension PhoiMauResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        return dataSource.count == 0 ? 0 : dataSource.count + 1
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(PhoiMauResultTableViewCell.self)
        let item = dataSource[indexPath.row]
        cell.configure(item)
        cell.panAction = { [weak self] isRight in
            guard let self = self else { return }
            if isRight {
                self.didBack()
            }
            else {
                self.selectImage(item)
            }
        }
        cell.selectAction = { [unowned self] in
            self.selectImage(item)
        }
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension PhoiMauResultViewController: UITableViewDelegate {
    
}
