//
//  String+Additions.swift
//  AWTest
//
//  Created by Ahmad Waqas on 11/21/19.
//  Copyright © 2019 Ahmad Waqas. All rights reserved.
//

import Foundation

extension String {
    
    
    
    func formattedDateFromStringToDate(_ pattern: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        
        return dateFormatter.date(from: self)
    }
}
