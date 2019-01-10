//
//  PaintCalculatorV2TableViewCell.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 1/10/19.
//  Copyright © 2019 Stage Group. All rights reserved.
//

import UIKit
import DropDown

protocol PaintCalculatorV2TableViewCellDelegate: class {
    func paintCalculatorV2TableViewCellDelegate(_ cell: PaintCalculatorV2TableViewCell, didSelect product: PaintCalculatorProduct?, numOfLayers: Int)
}

class PaintCalculatorV2TableViewCell: UITableViewCell, ReusableView {

    // MARK: - Outlets
    @IBOutlet weak var categoryNameLabel: UILabel! {
        didSet {
            categoryNameLabel.text = ""
        }
    }
    @IBOutlet weak var productViewButton: ViewButton! {
        didSet {
            productViewButton.backgroundColor = .white
            productViewButton.layer.cornerRadius = 5
            productViewButton.layer.borderColor = UIColor(hexString: "EBECEB")!.cgColor
            productViewButton.layer.borderWidth = 1
            productViewButton.touchUpInsideAction = productViewButtonHandler
        }
    }
    @IBOutlet weak var productNameLabel: UILabel! {
        didSet {
            productNameLabel.text = "Không sử dụng"
        }
    }
    @IBOutlet weak var layerViewButton: ViewButton! {
        didSet {
            layerViewButton.backgroundColor = .white
            layerViewButton.layer.cornerRadius = 5
            layerViewButton.layer.borderColor = UIColor(hexString: "EBECEB")!.cgColor
            layerViewButton.layer.borderWidth = 1
            layerViewButton.touchUpInsideAction = layerViewButtonHandler
        }
    }
    @IBOutlet weak var numOfLayersLabel: UILabel! {
        didSet {
            numOfLayersLabel.text = "1"
        }
    }
    
    // MARK: - Properties
    private var category: PaintCalculatorCategory!
    private var selectedProduct: PaintCalculatorProduct? {
        didSet {
            delegate?.paintCalculatorV2TableViewCellDelegate(self, didSelect: selectedProduct, numOfLayers: numOfLayers)
        }
    }
    private var numOfLayers = 1 {
        didSet {
            numOfLayersLabel.text = "\(numOfLayers)"
            delegate?.paintCalculatorV2TableViewCellDelegate(self, didSelect: selectedProduct, numOfLayers: numOfLayers)
        }
    }
    
    weak var delegate: PaintCalculatorV2TableViewCellDelegate?
    
    // MARK: - Methods
    func configure(_ category: PaintCalculatorCategory) {
        self.category = category
        
        categoryNameLabel.text = category.name
    }
    
    private func productViewButtonHandler() {
        showDropDown(anchorView: productViewButton, dataSource: ["Không sử dụng"] + category.products.compactMap({ $0.name })) { [weak self] (index, value) in
            guard let self = self else { return }
            self.productViewButton.subviews.forEach {
                if let label = $0 as? UILabel {
                    label.text = value
                    return
                }
            }
            
            if index == 0 {
                self.selectedProduct = nil
            }
            else {
                self.selectedProduct = self.category.products[index - 1]
            }
        }
    }
    
    private func layerViewButtonHandler() {
        showDropDown(anchorView: layerViewButton, dataSource: (1...3).map({ "\($0)" })) { [weak self] (index, value) in
            guard let self = self else { return }
            self.layerViewButton.subviews.forEach {
                if let label = $0 as? UILabel {
                    label.text = value
                    self.numOfLayers = Int(value) ?? 1
                    return
                }
            }
        }
    }
    
    private func showDropDown(anchorView: UIView, dataSource: [String], selectingHandler: @escaping (Int, String)->()) {
        let dropDown = DropDown()
        dropDown.anchorView = anchorView
        
        dropDown.bottomOffset = CGPoint(x: 0, y: anchorView.frame.height)
        
        DropDown.setupDefaultAppearance()
        let appearance = DropDown.appearance()
        appearance.backgroundColor = .white
        appearance.selectionBackgroundColor = .clear
        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
        appearance.cornerRadius = 10
        appearance.shadowColor = .lightGray
        appearance.shadowOpacity = 0.7
        appearance.shadowRadius = 10
        appearance.animationduration = 0.25
        
        dropDown.dataSource = dataSource
        dropDown.selectionAction = { (index, item) in
            selectingHandler(index, item)
        }
        dropDown.dismissMode = .automatic
        dropDown.direction = .bottom
        
        dropDown.show()
    }
}
