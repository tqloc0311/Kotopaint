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
    
    public var year: Int {
        get {
            return Calendar.current.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = Calendar.current.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = Calendar.current.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// SwifterSwift: Month.
    ///
    ///     Date().month -> 1
    ///
    ///     var someDate = Date()
    ///     someDate.month = 10 // sets someDate's month to 10.
    ///
    public var month: Int {
        get {
            return Calendar.current.component(.month, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentMonth = Calendar.current.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = Calendar.current.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// SwifterSwift: Day.
    ///
    ///     Date().day -> 12
    ///
    ///     var someDate = Date()
    ///     someDate.day = 1 // sets someDate's day of month to 1.
    ///
    public var day: Int {
        get {
            return Calendar.current.component(.day, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentDay = Calendar.current.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = Calendar.current.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }
}
