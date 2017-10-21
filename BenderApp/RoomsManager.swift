//
//  RoomsManager.swift
//  BenderApp
//
//  Created by bestK1ng on 21/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit
import RealmSwift

class RoomsManager {

    static let shared = RoomsManager()
    
    // Get the default Realm
    let realm = try! Realm()
    
    init() {
        
        // Check if rooms database exist
        let rooms = realm.objects(RealmRoom.self)
        if rooms.count == 0 {
            createDatabase()
        }
    }
    
    func getRoom(id: Int) -> Room? {
        
        let rooms = realm.objects(RealmRoom.self).filter("id = %ld", id)
        
        if rooms.count == 0 {
            return nil
        }

        if let realmRoom = rooms.first {
            return Room(realm: realmRoom)
        } else {
            return nil
        }
    }

    private func createDatabase() {
        
        // Floor 1
        let room11 = Room(id: 11, enters: [], frame: CGRect())
        
        try! realm.write {
            realm.add(room11.realm())
        }
    }
}
