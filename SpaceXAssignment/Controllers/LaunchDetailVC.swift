//
//  LaunchDetailVC.swift
//  AWTest
//
//  Created by Ahmad Waqas on 11/20/19.
//  Copyright © 2019 Ahmad Waqas. All rights reserved.
//

import UIKit

class LaunchDetailVC: UIViewController {
    
    //==================
    //MARK:- IBOutlets
    //==================

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblRocketDescription: UILabel!
    
    @IBOutlet weak var lblLaunchInfo: UILabel!
    
    @IBOutlet weak var btnClickWiki: UIButton!
    
    //==================
    //MARK:- Variables
    //==================
    
    var launch: Launch?
    var rocketx: Rocket?
    //======================
    //MARK:- Static Method
    //======================
    
    static func loadLaunchDetailVC() -> LaunchDetailVC {
        return UIStoryboard.storyboardMain().loadViewController(Constants.VCControlrs.vc_launchDetail.rawValue) as! LaunchDetailVC
    }
    //===================
    //MARK:- LifeCycle
    //===================

   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureButton()
        getOneLaunchInfo()
        getOneRocket()
        self.title = launch?.missionName
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //=======================
    //MARK:- Local Methods
    //=======================
    
    private func getOneLaunchInfo() {
        
        guard let launchi = launch else {
            return
        }
        
        Launch.getLaunchByFlightID(flightID: launchi.flightNumber, success: { [unowned self] (launchOne) in
            if let launche = launchOne {
                self.setLaunchInfo(launchX: launche)
            }else {
                self.setLaunchInfo(launchX: launchi)
            }
        }) { [unowned self] (error) in
            Utility.showErrorAlert(caller: self, message: error?.localizedDescription ?? Constants.ERROR_MSG_ONE_LAUNCH)
        }
    }
    
    private func getOneRocket() {
        guard let launchi = launch else {
            return
        }
        
        Utility.showHud()
        
        Rocket.getRocketByFlightID(rocketID: launchi.rocket.rocketID, success: { [unowned self] (rocketX) in
            Utility.hideHud()
            if let xRocket = rocketX {
                
                self.setRocketInfo(rocketX: xRocket)
            }
        }) { [unowned self] (error) in
            Utility.hideHud()
            Utility.showErrorAlert(caller: self, message: Constants.ERROR_MSG_ONE_ROCKET)
        }
        
        Utility.getImageData(url: launchi.links) { [unowned self] (data) in
            if let dataImage = data {
                
                self.imgView.image = UIImage(data: dataImage)
            }
        }
    }
    
    private func setRocketInfo(rocketX: Rocket) {
        rocketx = rocketX
        lblRocketDescription.text = rocketX.description
        

    }
    
    private func setLaunchInfo(launchX: Launch) {
//        lblLaunchInfo.text = launchX.missionName + "with flight number " + "\(launchX.flightNumber)" + " was launched in the year  " + launchX.launchYear
        if let launch = launch {
            
            lblLaunchInfo.text = launch.missionName + "with flight number " + "\(launch.flightNumber)" + " was launched in the year  " + launch.launchYear
        }
    }
    
    private func configureButton() {
        btnClickWiki.backgroundColor = UIColor.blue
        btnClickWiki.layer.cornerRadius = 8.0
        btnClickWiki.clipsToBounds = true
    }
    
    //===================
    //MARK:- IBActions
    //===================

    @IBAction func ClickWikiTapped(_ sender: UIButton) {
        
        guard let urlWiki = rocketx?.wikipedia else {
            return
        }
        
        if let url = URL(string: urlWiki) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
        
    }
    
    
}
