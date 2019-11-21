//
//  Utilities.swift
//  AWTest
//
//  Created by Ahmad Waqas on 11/20/19.
//  Copyright © 2019 Ahmad Waqas. All rights reserved.
//

import Foundation
import UIKit


class Utility: NSObject {
    
    //MARK:- Alert Methods
    
    class func showErrorAlert(caller:UIViewController,message:String) -> Void {
        
        Utility.showAlert(caller: caller, title: "Alert", message: message)
    }
    
    class func showAlert(caller:UIViewController,title:String?,message:String) -> Void {
        
        
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        caller.present(alert, animated: true, completion: nil)
    }
    class func showAlertWithButton(caller:UIViewController,title: String, message: String,buttonTitle:String = "Cancel" ,buttonStyle: UIAlertAction.Style = UIAlertAction.Style.cancel , buttonHandler: ((UIAlertAction) -> Void)? = nil ) -> Void {
        
        
        let alert = UIAlertController(title:title, message:message, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: buttonStyle, handler:buttonHandler))
        
        caller.present(alert, animated: true, completion: {
            
        })
    }
    
    class func getImageData(url : URL, success: @escaping (_ dataImg: Data?) -> Void ) {
//        if let url = URL(string: stringUrl){
            let request = NetworkRequests(url: url)
            request.execute { (data,_,_) in
                
                if let dataReceived = data {
                    
                   success(dataReceived)
                }else {
                    success(nil)
                }
            }
//        }
    }
    
    class func showHud() {
        let viewSplash = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        let imgViewLogo = UIImageView(image: UIImage(named: "rocketX"))
        imgViewLogo.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        let lbl = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2, width: 300, height: 50))
        lbl.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2+120)
        lbl.numberOfLines = 1
    
        viewSplash.addSubview(imgViewLogo)
            viewSplash.addSubview(lbl)
            
            
        viewSplash.tag = Constants.TAG_HUD_VIEW
        viewSplash.backgroundColor = UIColor.lightGray
        viewSplash.alpha = 0.75
           
            
        
        guard let keyWindow = UIApplication.shared.keyWindow else {return}
        keyWindow.addSubview(viewSplash)
        for item in keyWindow.subviews
            where item.tag == Constants.TAG_HUD_VIEW {
                keyWindow.bringSubviewToFront(item)
        }
        viewSplash.addConstraint(NSLayoutConstraint(item: imgViewLogo, attribute: .centerY, relatedBy: .equal, toItem: viewSplash, attribute: .centerY, multiplier: 1, constant: 0))
        viewSplash.addConstraint(NSLayoutConstraint(item: imgViewLogo, attribute: .centerX, relatedBy: .equal, toItem: viewSplash, attribute: .centerX, multiplier: 1, constant: 0))
        
        viewSplash.addConstraint(NSLayoutConstraint(item: imgViewLogo, attribute: .top, relatedBy: .equal, toItem: lbl, attribute: .top, multiplier: 1, constant: 20))
        viewSplash.addConstraint(NSLayoutConstraint(item: lbl, attribute: .centerX, relatedBy: .equal, toItem: viewSplash, attribute: .centerX, multiplier: 1, constant: 0))
        
        
    }
    
    class func hideHud() {
        
        guard let keyWindow = UIApplication.shared.keyWindow else {return}
        for item in keyWindow.subviews
            where item.tag == Constants.TAG_HUD_VIEW {
                item.removeFromSuperview()
        }
    }
    
}
