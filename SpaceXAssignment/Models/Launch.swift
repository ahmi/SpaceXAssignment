//
//  Launch.swift
//  AWTest
//
//  Created by Ahmad Waqas on 11/20/19.
//  Copyright © 2019 Ahmad Waqas. All rights reserved.
//

import Foundation


public struct Launch: Codable {
    // Getting only the project related properties as Launch object contains way to many properties
    var flightNumber: Int
    var missionName: String
    var launchYear: String
    var launchDateUTC: Date
    var launchSuccess: Bool
    var rocket: Rocket
    var links: URL
    
    public init(from decoder: Decoder) throws {
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        missionName = try container.decode(String.self, forKey: .missonName)
        launchYear = try container.decode(String.self, forKey: .launchYear)
//        launchDateUTC = try container.decode(String.self, forKey: .launchDateUTC)
        launchDateUTC = try container.decode(Date.self, forKey: .launchDateUTC)
        launchSuccess = try container.decode(Bool.self, forKey: .launchSuccess)
        rocket = try container.decode(Rocket.self, forKey: .rocket)
        
        let linksContainer = try container.nestedContainer(keyedBy: CodingKeys.LinksKeys.self, forKey: .links)
        links = try linksContainer.decode(URL.self, forKey: .linkImage)
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}

extension Launch {

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missonName = "mission_name"
        case launchYear = "launch_year"
        case launchDateUTC = "launch_date_utc"
        case launchSuccess = "launch_success"
        case rocket
        case links
        
        enum LinksKeys: String, CodingKey {
            case linkImage = "mission_patch_small"
        }
    }
    
    static func getLaunches(success: @escaping (_ launches:[Launch]?) -> Void, failureBlock failure: @escaping (_ error: Error?)-> Void) {
        
        let url = URL(string: "https://api.spacexdata.com/v3/launches?limit=10")!
        let request = NetworkRequests(url: url)
        request.execute { (data,response,error) in
            
            // NOTE: - Remove this late : added just to check the response from API in readable form
//            guard let dataResponse = data,
//                   error == nil else {
//                   print(error?.localizedDescription ?? "Response Error")
//                   return }
//             do{
//                 //here dataResponse received from a network request
//                 let jsonResponse = try JSONSerialization.jsonObject(with:
//                                        dataResponse, options: [])
//                 print(jsonResponse) //Response result
//              } catch let parsingError {
//                 print("Error", parsingError)
//            }
            
            if let dataReceived = data {
                
                let lauch = decodes(dataReceived)
                success(lauch)
            }else {
                success(nil)
            }
            
            if let errorReceived = error {
                failure(errorReceived)
            }
        }
    }
    static func getLaunchByFlightID(flightID: Int, success: @escaping (_ launches:Launch?) -> Void, failureBlock failure: @escaping (_ error: Error?)-> Void) {
        
        let url = URL(string: Constants.APIEndPoints.base.rawValue + Constants.APIEndPoints.oneLaunch.rawValue + String(flightID))!
            let request = NetworkRequests(url: url)
            request.execute { (data,response,error) in
                
               
                if let dataReceived = data {
                    
                    let lauch = decodeSingle(dataReceived)
                    success(lauch)
                }else {
                    success(nil)
                }
                
                if let errorReceived = error {
                    failure(errorReceived)
                }
            }
        }
    
    static func decodeSingle(_ data: Data) -> Launch? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
        
        guard let launch = try? decoder.decode(Launch.self, from: data) else{
            return nil
        }
        return launch
    }
    
    static func decodes(_ data: Data) -> [Launch]? {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)

        
        guard let launch = try? decoder.decode([Launch].self, from: data) else{
            return nil
        }
        return launch
    }

}
/*
 
 {
     "flight_number": 1,
     "mission_name": "FalconSat",
     "mission_id": [],
     "upcoming": false,
     "launch_year": "2006",
     "launch_date_unix": 1143239400,
     "launch_date_utc": "2006-03-24T22:30:00.000Z",
     "launch_date_local": "2006-03-25T10:30:00+12:00",
     "is_tentative": false,
     "tentative_max_precision": "hour",
     "tbd": false,
     "launch_window": 0,
     "rocket": {
         "rocket_id": "falcon1",
         "rocket_name": "Falcon 1",
         "rocket_type": "Merlin A",
         "first_stage": {
             "cores": [
                 {
                     "core_serial": "Merlin1A",
                     "flight": 1,
                     "block": null,
                     "gridfins": false,
                     "legs": false,
                     "reused": false,
                     "land_success": null,
                     "landing_intent": false,
                     "landing_type": null,
                     "landing_vehicle": null
                 }
             ]
         },
         "second_stage": {
             "block": 1,
             "payloads": [
                 {
                     "payload_id": "FalconSAT-2",
                     "norad_id": [],
                     "reused": false,
                     "customers": [
                         "DARPA"
                     ],
                     "nationality": "United States",
                     "manufacturer": "SSTL",
                     "payload_type": "Satellite",
                     "payload_mass_kg": 20,
                     "payload_mass_lbs": 43,
                     "orbit": "LEO",
                     "orbit_params": {
                         "reference_system": "geocentric",
                         "regime": "low-earth",
                         "longitude": null,
                         "semi_major_axis_km": null,
                         "eccentricity": null,
                         "periapsis_km": 400,
                         "apoapsis_km": 500,
                         "inclination_deg": 39,
                         "period_min": null,
                         "lifespan_years": null,
                         "epoch": null,
                         "mean_motion": null,
                         "raan": null,
                         "arg_of_pericenter": null,
                         "mean_anomaly": null
                     },
                     "uid": "UerI6qmZTU2Fx2efDFm3QQ=="
                 }
             ]
         },
         "fairings": {
             "reused": false,
             "recovery_attempt": false,
             "recovered": false,
             "ship": null
         }
     },
     "ships": [],
     "telemetry": {
         "flight_club": null
     },
     "launch_site": {
         "site_id": "kwajalein_atoll",
         "site_name": "Kwajalein Atoll",
         "site_name_long": "Kwajalein Atoll Omelek Island"
     },
     "launch_success": false,
     "launch_failure_details": {
         "time": 33,
         "altitude": null,
         "reason": "merlin engine failure"
     },
     "links": {
         "mission_patch": "https://images2.imgbox.com/40/e3/GypSkayF_o.png",
         "mission_patch_small": "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png",
         "reddit_campaign": null,
         "reddit_launch": null,
         "reddit_recovery": null,
         "reddit_media": null,
         "presskit": null,
         "article_link": "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html",
         "wikipedia": "https://en.wikipedia.org/wiki/DemoSat",
         "video_link": "https://www.youtube.com/watch?v=0a_00nJ_Y88",
         "youtube_id": "0a_00nJ_Y88",
         "flickr_images": []
     },
     "details": "Engine failure at 33 seconds and loss of vehicle",
     "static_fire_date_utc": "2006-03-17T00:00:00.000Z",
     "static_fire_date_unix": 1142553600,
     "timeline": {
         "webcast_liftoff": 54
     },
     "crew": null
 },
 
 */
