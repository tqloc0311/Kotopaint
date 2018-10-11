//
//  Date.swift
//  DrVisualProject
//
//  Created by Tran Quoc Loc on 10/3/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

extension Date
{
    init?(string dateString:String, format: String) {
        if dateString == "" {
            return nil
        }
        else {
            let dateStringFormatter = DateFormatter()
            dateStringFormatter.dateFormat = (format)
            dateStringFormatter.locale = .current
            dateStringFormatter.timeZone = .current
            if let d = dateStringFormatter.date(from: dateString) {
                self = d
            }
            else {
                return nil
            }
        }
    }
    
    init?(string dateString:String) {
        guard let date = Date(string: dateString, format: "dd/MM/yyyy") else {
            return nil
        }
        
        self = date
    }
    
    func toString(withFormat format: String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    
    static func >(lhs: inout Date, rhs: Date) -> Bool {
        return lhs.compare(rhs) == ComparisonResult.orderedDescending
    }
    
    static func >=(lhs: inout Date, rhs: Date) -> Bool {
        return lhs.compare(rhs) == ComparisonResult.orderedDescending || lhs.compare(rhs) == ComparisonResult.orderedSame
    }
    
    static func <(lhs: inout Date, rhs: Date) -> Bool {
        return lhs.compare(rhs) == ComparisonResult.orderedAscending
    }
    
    static func <=(lhs: inout Date, rhs: Date) -> Bool {
        return lhs.compare(rhs) == ComparisonResult.orderedAscending || lhs.compare(rhs) == ComparisonResult.orderedSame
    }
    
    static func ==(lhs: inout Date, rhs: Date) -> Bool {
        return lhs.compare(rhs) == ComparisonResult.orderedSame
    }
}
