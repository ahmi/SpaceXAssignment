//
//  Date+Additions.swift
//  AWTest
//
//  Created by Ahmad Waqas on 11/20/19.
//  Copyright © 2019 Ahmad Waqas. All rights reserved.
//

import Foundation


extension Date {
    
    
    func formattedDate(_ pattern:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en")
        
        return dateFormatter.string(from: self)
        
    }
    
    func formattedDate(_ style:DateFormatter.Style) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.string(from: self)
        
    }
    
    func UTCToEST(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
//        dateFormatter.timeZone = TimeZone(abbreviation: "ET")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "ET")
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    func formattedDateInLocal(_ pattern:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en")
        
        return dateFormatter.string(from: self)
        
    }
    
    func datetoString(_ pattern: String = "hh:mm a") -> String {
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter.string(from: self)
    }
    
    
    func dateAt(hours: Int, minutes: Int) -> Date
    {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        //get the month/day/year componentsfor today's date.
        
        
        var date_components = calendar.components(
            [NSCalendar.Unit.year,
             NSCalendar.Unit.month,
             NSCalendar.Unit.day],
            from: self)
        
        //Create an NSDate for the specified time today.
        date_components.hour = hours
        date_components.minute = minutes
        date_components.second = 0
        
        let newDate = calendar.date(from: date_components)!
        return newDate
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
   
    
}


extension DateFormatter {
    static let fullISO8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
