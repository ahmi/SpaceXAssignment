//
//  LaunchCell.swift
//  AWTest
//
//  Created by Ahmad Waqas on 11/20/19.
//  Copyright © 2019 Ahmad Waqas. All rights reserved.
//

import UIKit

class LaunchCell: UITableViewCell {

    
    //==================
    //MARK:- IBOutlets
    //==================

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblMissionName
    : UILabel!
    
    @IBOutlet weak var lblLaunchDate: UILabel!
    
    @IBOutlet weak var lblMissionStatus: UILabel!
    
    
    //===================
    //MARK:- LifeCycle
    //===================

   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataLaunch(launch: Launch) {
        
        lblMissionName.text = launch.missionName
        lblLaunchDate.text = launch.launchYear
        if launch.launchSuccess {
            
            lblMissionStatus.text = "Success"
            lblMissionStatus.textColor = UIColor.green
        }else {
            lblMissionStatus.text = "Failure"
            lblMissionStatus.textColor = UIColor.red
        }
        Utility.getImageData(url: launch.links) { [unowned self] (data) in
            if let dataImage = data {
                
                self.imgView.image = UIImage(data: dataImage)
            }
        }
    }
    
    
}
