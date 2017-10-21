//
//  NetworkManager.swift
//  BenderApp
//
//  Created by bestK1ng on 21/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    // MARK: API
    
    func getRoute(from: Int, to: Int, success: ((Route) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        
        let parameters = ["from": from, "to": to]
        
        Alamofire.request("http://77.244.216.138:3000/get-route/", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if let json = response.result.value {
                if let dict = json as? Dictionary<String, Any>, let rooms = dict["data"] as? [Dictionary<String, Any>] {
                    
                    var path: [Int] = []
                    for room in rooms {
                        path.append(Int((room["roomId"] as? Int) ?? 0))
                    }
                    
                    success?(Route(path: path))
                }
            } else {
                failure?(nil)
            }
        }
    }
}
