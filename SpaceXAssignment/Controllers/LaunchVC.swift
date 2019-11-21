//
//  LaunchVC.swift
//  AWTest
//
//  Created by Ahmad Waqas on 11/20/19.
//  Copyright © 2019 Ahmad Waqas. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {

    //==================
    //MARK:- IBOutlets
    //==================

    @IBOutlet weak var tblLaunch: UITableView!

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var switchFilter: UISwitch!
    
    
    //==================
    //MARK:- Variables
    //==================
    
    var launchList:[Launch] = []
    var yearLaunch:[YearLaunch] = []
    var missionNameLaunch: [MissionNameLaunch] = []
    var sortByLaunchYear = true
    var isFilterOn = false
    
    var filteredYearLaunch:[YearLaunch] = []
    var filteredMissionNameLaunch: [MissionNameLaunch] = []
    //======================
    //MARK:- Static Method
    //======================

    //===================
    //MARK:- LifeCycle
    //===================

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Launch List"
        configureTableView()
        getLaunches()
        isFilterOn = switchFilter.isOn
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
    
    private func configureTableView() {
        
        tblLaunch.delegate = self
        tblLaunch.dataSource = self
        tblLaunch.register(UINib(nibName: Constants.CustomCellsIdentifiers.LaunchCell, bundle: nil), forCellReuseIdentifier: Constants.CustomCellsIdentifiers.LaunchCell)
        tblLaunch.estimatedRowHeight = 116.0
        tblLaunch.rowHeight = UITableView.automaticDimension
    }
    
    private func getLaunches() {
        
        Utility.showHud()
        
        Launch.getLaunches(success: { [unowned self] (launches) in
            Utility.hideHud()
            if let launncches = launches {
                self.arrangeLaunchesForSections(launches: launncches)
            }
        }) { [unowned  self] (error) in
            Utility.hideHud()
            Utility.showErrorAlert(caller: self, message: error?.localizedDescription ?? Constants.ERROR_MSG_ALL_LAUNCHES)
        }
    }
    
    private func arrangeLaunchesForSections(launches: [Launch]) {
        
        let groups = Dictionary(grouping: launches, by: { $0.launchYear })
        
        yearLaunch = groups.map({ (key,value) in
            return YearLaunch(year: key, launches: value)
            })
        
        yearLaunch = yearLaunch.sorted(by: { (a, b) -> Bool in
            return a.year < b.year
        })

        
        
        let groupName = Dictionary(grouping: launches, by: { $0.missionName.first! })
        missionNameLaunch = groupName.map({ (arg0) -> MissionNameLaunch in
            
            
            let (key, value) = arg0
            return MissionNameLaunch(initialLetter: String(key), launches: value)
        })
        
        missionNameLaunch = missionNameLaunch.sorted(by: { (a, b) -> Bool in
            return a.initialLetter < b.initialLetter
        })
        
       
        
       let successLaunches = launches.filter({ $0.launchSuccess == true })
        
        let groupsSuccess = Dictionary(grouping: successLaunches, by: { $0.launchYear })
        
        filteredYearLaunch = groupsSuccess.map({ (key,value) in
            return YearLaunch(year: key, launches: value)
            })
        
        filteredYearLaunch = filteredYearLaunch.sorted(by: { (a, b) -> Bool in
            return a.year < b.year
        })
        
        let groupNameSuccess = Dictionary(grouping: successLaunches, by: { $0.missionName.first! })
        filteredMissionNameLaunch = groupNameSuccess.map({ (arg0) -> MissionNameLaunch in
            
            
            let (key, value) = arg0
            return MissionNameLaunch(initialLetter: String(key), launches: value)
        })
        
        filteredMissionNameLaunch = filteredMissionNameLaunch.sorted(by: { (a, b) -> Bool in
            return a.initialLetter < b.initialLetter
        })
        
        tblLaunch.reloadData()
        
    }
    


    //===================
    //MARK:- IBActions
    //===================
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        isFilterOn = sender.isOn
        tblLaunch.reloadData()
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            sortByLaunchYear = true
        }else if sender.selectedSegmentIndex == 1 {
            sortByLaunchYear = false
        }
        
        tblLaunch.reloadData()
    }
    
    
    
}

extension LaunchVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var secCount = 1
        
        if isFilterOn {
            if sortByLaunchYear {
                secCount = filteredYearLaunch.count
            }else {
                secCount = filteredMissionNameLaunch.count
            }
        }else {
            if sortByLaunchYear {
                secCount = yearLaunch.count
            }else {
                secCount = missionNameLaunch.count
            }
        }
        
        return secCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        
        if isFilterOn {
            if sortByLaunchYear {
                rowCount = filteredYearLaunch[section].launches.count
            }else {
                rowCount = filteredMissionNameLaunch[section].launches.count
            }
        }else {
            if sortByLaunchYear {
                rowCount = yearLaunch[section].launches.count
            }else {
                rowCount = missionNameLaunch[section].launches.count
            }
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CustomCellsIdentifiers.LaunchCell, for: indexPath) as! LaunchCell
        if isFilterOn {
            if sortByLaunchYear {
                cell.setDataLaunch(launch: filteredYearLaunch[indexPath.section].launches[indexPath.row])
            }else {
                cell.setDataLaunch(launch: filteredMissionNameLaunch[indexPath.section].launches[indexPath.row])
            }
        }else {
            if sortByLaunchYear {
                cell.setDataLaunch(launch: yearLaunch[indexPath.section].launches[indexPath.row])
            }else {
                cell.setDataLaunch(launch: missionNameLaunch[indexPath.section].launches[indexPath.row])
            }
        }
       
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var str = ""
        if isFilterOn {
            if sortByLaunchYear {
                str = filteredYearLaunch[section].year
            }else {
                str = filteredMissionNameLaunch[section].initialLetter
            }
        }else {
            if sortByLaunchYear {
                str = yearLaunch[section].year
            }else {
                str = missionNameLaunch[section].initialLetter
            }
        }
       
        
        let headerTitleView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30.0))
        let lbl = UILabel(frame: CGRect(x: 8, y: 0, width: UIScreen.main.bounds.width-16.0, height: 30.0))
        lbl.textAlignment = .left
        lbl.text = str
        lbl.textColor = UIColor.black
        lbl.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        headerTitleView.layer.borderWidth = 1
        headerTitleView.layer.borderColor = UIColor.darkGray.cgColor
        
        headerTitleView.addSubview(lbl)
        headerTitleView.backgroundColor = UIColor.lightGray
        return headerTitleView
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}

extension LaunchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var launcheeesss: Launch?
        
        let vc = LaunchDetailVC.loadLaunchDetailVC()
        if isFilterOn {
            if sortByLaunchYear {
                launcheeesss = filteredYearLaunch[indexPath.section].launches[indexPath.row]
            }else {
                launcheeesss = filteredMissionNameLaunch[indexPath.section].launches[indexPath.row]
            }
        }else {
            if sortByLaunchYear {
                launcheeesss = yearLaunch[indexPath.section].launches[indexPath.row]
            }else {
                launcheeesss = missionNameLaunch[indexPath.section].launches[indexPath.row]
            }
        }
        
        vc.launch = launcheeesss
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
