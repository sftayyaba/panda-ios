//
//  NSDate.swift
//  Pander
//
//  Created by Shery on 26/01/2018.
//

import Foundation

extension Date {
    
    var weekdayName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "E"
        return formatter.string(from: self as Date)
    }
    
    var weekdayNameFull: String {
        let formatter = DateFormatter(); formatter.dateFormat = "EEEE"
        return formatter.string(from: self as Date)
    }
    var monthName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "MMM"
        return formatter.string(from: self as Date)
    }
    var OnlyYear: String {
        let formatter = DateFormatter(); formatter.dateFormat = "YYYY"
        return formatter.string(from: self as Date)
    }
    
    var period: String {
        let formatter = DateFormatter(); formatter.dateFormat = "a"
        return formatter.string(from: self as Date)
    }
    
    var timeOnly: String {
        let formatter = DateFormatter(); formatter.dateFormat = "hh : mm"
        return formatter.string(from: self as Date)
    }
    
    var timeWithPeriod: String {
        let formatter = DateFormatter(); formatter.dateFormat = "hh : mm a"
        return formatter.string(from: self as Date)
    }
}
