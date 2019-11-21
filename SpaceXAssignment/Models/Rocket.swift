//
//  Rocket.swift
//  AWTest
//
//  Created by Ahmad Waqas on 11/20/19.
//  Copyright © 2019 Ahmad Waqas. All rights reserved.
//

import Foundation

struct Rocket: Codable {
    // Again taking only the main rocket properties to keep it simple
    
    var rocketID: String
    var rocketName: String
    var rocketType: String
    var description: String?
    var wikipedia: String?
    
    
    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
        case description
        case wikipedia
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rocketID = try container.decode(String.self, forKey: .rocketID)
        rocketName = try container.decode(String.self, forKey: .rocketName)
        rocketType = try container.decode(String.self, forKey: .rocketType)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        wikipedia = try container.decodeIfPresent(String.self, forKey: .wikipedia)
    
    }
       
       public func encode(to encoder: Encoder) throws {
           
       }
}

extension Rocket {
    
    static func getRocketByFlightID(rocketID: String, success: @escaping (_ rocket:Rocket?) -> Void, failureBlock failure: @escaping (_ error: Error?)-> Void) {
        
        let url = URL(string: Constants.APIEndPoints.base.rawValue + Constants.APIEndPoints.rocketOne.rawValue + String(rocketID))!
            let request = NetworkRequests(url: url)
            request.execute { (data,response,error) in
                
                if let dataReceived = data {
                    
                    let rocketx = decodeRocket(dataReceived)
                    success(rocketx)
                }else {
                    success(nil)
                }
                
                if let errorReceived = error {
                    failure(errorReceived)
                }
            }
        }
    
    static func decodeRocket(_ data: Data) -> Rocket? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
        
        guard let rocketX = try? decoder.decode(Rocket.self, from: data) else{
            return nil
        }
        return rocketX
    }
    
}

/*
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
 }
 */
