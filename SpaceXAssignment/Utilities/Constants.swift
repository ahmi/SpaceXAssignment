//
//  Constants.swift
//  AWTest
//
//  Created by Ahmad Waqas on 11/20/19.
//  Copyright © 2019 Ahmad Waqas. All rights reserved.
//

import Foundation

struct Constants {
    
    //==================================
    // ***** Custom Cells IDs *****
    //==================================
       
    struct CustomCellsIdentifiers {
        
        static let LaunchCell = "LaunchCell"
    }
    
    //================================
    // ***** String Messages ******
    //================================
    
    static let ERROR_MSG_ONE_LAUNCH = "Failed to get one launch info!"
    static let ERROR_MSG_ALL_LAUNCHES = "Space X launch data unavailable at the moment!"
    static let ERROR_MSG_ONE_ROCKET = "Space X Rocket not Found!"
    
    
    enum VCControlrs: String {
        case vc_launchDetail = "LaunchDetailVC"
    }
    
    enum APIEndPoints: String {
        case base = "https://api.spacexdata.com/v3/"
        case oneLaunch = "lauches/"
        case rocketOne = "rockets/"
    }
    
    static let TAG_HUD_VIEW = 787
    
}


//==================
//MARK:- IBOutlets
//==================

//==================
//MARK:- Variables
//==================

//======================
//MARK:- Static Method
//======================

//===================
//MARK:- LifeCycle
//===================

//=======================
//MARK:- Local Methods
//=======================

//===================
//MARK:- IBActions
//===================
