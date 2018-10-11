//
//  ColorPaletteView.swift
//  Kotopaint
//
//  Created by ProStageVN on 2/7/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import UIKit

protocol ColorPaletteDelegate {
    func colorPaletteDidSelect(_ color: UIColor)
}

class ColorPaletteView: UIView {
    
    // Constants

    // Properties
    var colorPatteCategoriesIndex = 0
    var colorData = [UIColor]()
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Methods
    func getMinMaxColor(from index: Int) -> (Int, Int) {
        switch index {
        case 1:
            return (0xEFCBAF, 0xAD271F)
        case 2:
            return (0xF4D984, 0xA98333)
        case 3:
            return (0xF0D9DC, 0x88222E)
        case 4:
            return (0xEAE3E6, 0x4D3B74)
        case 5:
            return (0xE1EEE7, 0x223E3E)
        case 6:
            return (0xCEDFE4, 0x16508B)
        case 7:
            return (0xDCEED5, 0x2B4132)
        case 8:
            return (0xF0EFD1, 0x504F31)
        default:
            return (0xFFFFFF, 0x0)
        }
    }
    
    func loadData() {
        colorData.removeAll()
        let (from, to) = getMinMaxColor(from: colorPatteCategoriesIndex)
        let fromColor = from.toUIColor()
        let toColor = to.toUIColor()
        for i in 0..<40 {
            let color = fromColor.interpolateRGBColorTo(end: toColor, fraction: CGFloat(1.0 / 40.0 * Double(i)))
            colorData.append(color)
        }
    }
    
    func setupCollectionView() {
        if collectionView == nil {return}
        collectionView.register(UINib(nibName: String(describing: ColorPalleteCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ColorPalleteCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.delaysContentTouches = false
        for view in collectionView.subviews {
            if view is UIScrollView {
                (view as! UIScrollView).delaysContentTouches = false
                break
            }
        }
        
        loadData()
        
        collectionView.reloadData()
    }
    
    // Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupCollectionView()
    }
}

extension ColorPaletteView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorPalleteCell.self), for: indexPath) as? ColorPalleteCell else {return UICollectionViewCell()}
        cell.backgroundColor = colorData[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  4
        let collectionViewSize = collectionView.frame.size.width - padding * 8
        let width = collectionViewSize / 9
        return CGSize(width: width, height: width * IMAGE_RATIO)
    }
}
