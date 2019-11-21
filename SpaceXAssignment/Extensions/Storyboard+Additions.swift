//
//  Storyboard+Additions.swift
//  AWTest
//
//  Created by Ahmad Waqas on 11/21/19.
//  Copyright © 2019 Ahmad Waqas. All rights reserved.
//

import Foundation

import UIKit

extension UIStoryboard {
    
    //=====================================
    //MARK:- Storyboards Specific Methods
    //=====================================
    
    class func storyboardMain() -> UIStoryboard {
        return storyboard(loadWithName: "Main")
    }
    
    //=================================
    //MARK:- Generic Methods
    //=================================
    
    func loadViewController(_ identifier:String) -> UIViewController {
        return self.instantiateViewController(withIdentifier: identifier)
    }
    
    fileprivate static func storyboard(loadWithName name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: Bundle.main)
    }
    
}
