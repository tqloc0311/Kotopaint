//
//  UIColor.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

extension UIColor {
    
    struct ColorComponents {
        var r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat
    }
    
    func brightened(by factor: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * factor, alpha: a)
    }
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    func rgb() -> (Int, Int, Int, Int) {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            
            return (iAlpha, iRed, iGreen, iBlue)
        } else {
            return (0, 0, 0, 0)
        }
    }
    
    func getComponents() -> ColorComponents {
        if (cgColor.numberOfComponents == 2) {
            let cc = cgColor.components!
            return ColorComponents(r:cc[0], g:cc[0], b:cc[0], a:cc[1])
        }
        else {
            let cc = cgColor.components!
            return ColorComponents(r:cc[0], g:cc[1], b:cc[2], a:cc[3])
        }
    }
    
    func interpolateRGBColorTo(end: UIColor, fraction: CGFloat) -> UIColor {
        var f = max(0, fraction)
        f = min(1, fraction)
        
        let c1 = self.getComponents()
        let c2 = end.getComponents()
        
        let r = c1.r + (c2.r - c1.r) * f
        let g = c1.g + (c2.g - c1.g) * f
        let b = c1.b + (c2.b - c1.b) * f
        let a = c1.a + (c2.a - c1.a) * f
        
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
}
