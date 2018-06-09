//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

extension String {
    
    static func getDayInWeek(dateInt: Int) -> String{
        
        let date = Date(timeIntervalSince1970: TimeInterval(dateInt))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    var isValidCityName: Bool {
        
        if(!self.isBlank && self.count >= 3){
            return true
        }
        return false
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    static func getTimeFrom(dateInt: Int) -> String{
        
        let date = Date(timeIntervalSince1970: TimeInterval(dateInt))
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        return formatter.string(from: date)
    }
}
