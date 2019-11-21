//
//  NetworkRequests.swift
//  AWTest
//
//  Created by Ahmad Waqas on 11/20/19.
//  Copyright © 2019 Ahmad Waqas. All rights reserved.
//

import Foundation


class NetworkRequests {
    
    let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func execute(withCompletion completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response:URLResponse?, error:Error?) -> Void in
            completion(data,response,error)
        })
        task.resume()
        
        
        
    }
}
