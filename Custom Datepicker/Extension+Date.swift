//
//  Extension+Date.swift
//  CustomDatePicker
//
//  Created by Kathiresan  on 09/04/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import Foundation

// MARK: - Date Extenstion
extension Date {
    
    /// Date formatted of Day, date, month
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM"
        let dateInString = formatter.string(from: self)
        return dateInString
    }
    
    /// Date formatted of Hour minutes
    var time: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let dateInString = formatter.string(from: self)
        return dateInString
    }
    
}
