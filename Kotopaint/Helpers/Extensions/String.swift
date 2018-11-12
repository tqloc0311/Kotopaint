//
//  String.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        if self.isEmpty {
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9]{1,}[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func html(size: CGFloat = 17) -> NSAttributedString {
        guard
            let data = data(using: .utf8)
        else { return NSAttributedString() }
        
        do {
            let attributedString = try NSMutableAttributedString(data: data, options: [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
                ], documentAttributes: nil)
            let range = NSRange(location: 0, length: attributedString.string.count)
            attributedString.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)], range: range)
            
            return attributedString
        } catch {
            return NSAttributedString()
        }
    }
    
    func encodeToInt() -> Int {
        return self.ascii.compactMap({ Int($0) }).reduce(0, +)
    }
}

extension StringProtocol {
    var ascii: [UInt32] {
        return unicodeScalars.compactMap { $0.isASCII ? $0.value : nil }
    }
}
extension Character {
    var ascii: UInt32? {
        return String(self).ascii.first
    }
}
