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
                        let roomID = room["roomId"] as? String
                        if let roomID = roomID, let number = Int(roomID) {
                            path.append(number)
                        }
                    }
                    
                    success?(Route(path: path))
                } else {
                    failure?(nil)
                }
            } else {
                failure?(nil)
            }
        }
    }
    
    typealias Room = (id: Int, congestion: Float)
    
    func getAllRooms(success: (([Room]) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        
        let parameters = ["floor": 1]
        
        Alamofire.request("http://77.244.216.138:3000/get-rooms/", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if let json = response.result.value {
                if let dict = json as? Dictionary<String, Any>, let rooms = dict["data"] as? [Dictionary<String, Any>] {
                    
                    var finalRooms: [Room] = []
                    for room in rooms {
                        let roomID = room["roomId"] as? String
                        let congestion = room["load"] as? Float
                        
                        if let roomID = roomID, let digitRoomID = Int(roomID), let congestion = congestion {
                            finalRooms.append((id: digitRoomID, congestion: congestion))
                        }
                    }
    
                    success?(finalRooms)
                } else {
                    failure?(nil)
                }
            } else {
                failure?(nil)
            }
        }
    }
    
    typealias Collection = (title: String, imageURL: URL)
    
    func getCollections(success: (([Collection]) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        
        Alamofire.request("http://77.244.216.138:3000/static/info.json", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if let json = response.result.value, let responses = json as? [Dictionary<String, Any>] {
                
                var titles: [String] = []
                var collections: [Collection] = []
                
                for response in responses {
                    
                    let about = response["about"] as! Dictionary<String, Any>
                    if let title = about["Коллекция"] as? String {
                        
                        let urlString = response["img"] as! String
                        
                        if titles.contains(title) {
                            // ..
                        } else if let url = URL(string: urlString) {
                            titles.append(title)
                            collections.append((title: title, imageURL: url))
                        }
                    }
                }
                
                success?(collections)
            } else {
                failure?(nil)
            }
        }
    }
    
    typealias Category = (title: String, imageURL: URL)
    
    func getCategories(success: (([Category]) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        
        Alamofire.request("http://77.244.216.138:3000/static/info.json", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if let json = response.result.value, let responses = json as? [Dictionary<String, Any>] {
                
                var titles: [String] = []
                var categories: [Category] = []
                
                for response in responses {
                    
                    let about = response["about"] as! Dictionary<String, Any>
                    if let title = about["Категория"] as? String {
                        
                        let urlString = response["img"] as! String
                        
                        if titles.contains(title) {
                            // ..
                        } else if let url = URL(string: urlString) {
                            titles.append(title)
                            categories.append((title: title, imageURL: url))
                        }
                    }
                }
                
                success?(categories)
            } else {
                failure?(nil)
            }
        }
    }
    
    
    typealias Picture = (id: String, imageURL: URL)
    
    func getPicturesForCollection(title: String, success: (([Picture]) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        
        Alamofire.request("http://77.244.216.138:3000/static/info.json", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if let json = response.result.value, let responses = json as? [Dictionary<String, Any>] {
                
                var pictures: [Picture] = []
                
                for response in responses {
                    
                    let about = response["about"] as! Dictionary<String, Any>
                    if let currentTitle = about["Коллекция"] as? String {
                        let urlString = response["img"] as! String
                        let id = about["Инвентарный_номер"] as? String
                        
                        if title == currentTitle, let url = URL(string: urlString), let id = id {
                            pictures.append((id: id, imageURL: url))
                        }
                    }
                }
                
                success?(pictures)
            } else {
                failure?(nil)
            }
        }
    }
    
    func getPicturesForCategory(title: String, success: (([Picture]) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        
        Alamofire.request("http://77.244.216.138:3000/static/info.json", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if let json = response.result.value, let responses = json as? [Dictionary<String, Any>] {
                
                var pictures: [Picture] = []
                
                for response in responses {
                    
                    let about = response["about"] as! Dictionary<String, Any>
                    if let currentTitle = about["Категория"] as? String {
                        let urlString = response["img"] as! String
                        let id = about["Инвентарный_номер"] as? String
                        
                        if title == currentTitle, let url = URL(string: urlString), let id = id {
                            pictures.append((id: id, imageURL: url))
                        }
                    }
                }
                
                success?(pictures)
            } else {
                failure?(nil)
            }
        }
    }
    
    func getPicture(id: String, success: ((PictureInfo) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        
        Alamofire.request("http://77.244.216.138:3000/static/info.json", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if let json = response.result.value, let responses = json as? [Dictionary<String, Any>] {
    
                for response in responses {
                    let about = response["about"] as! Dictionary<String, Any>
                    if let currentID = about["Инвентарный_номер"] as? String, currentID == id {
                        
                        let pictureInfo = PictureInfo(dictionary: about)

                        var roomString = response["room"] as? String
                        if var roomString = roomString {
                            roomString = roomString.trimmingCharacters(in: CharacterSet.decimalDigits.inverted)
                            pictureInfo.room = Int(roomString)
                        }
                        
                        let urlString = response["img"] as! String
                        pictureInfo.imageURL = URL(string: urlString)!
                        
                        success?(pictureInfo)
                    }
                }
                
                failure?(nil)
            } else {
                failure?(nil)
            }
        }
    }
}
