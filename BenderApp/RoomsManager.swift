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
    
    let rewriteRooms = true
    
    // Get the default Realm
    let realm = try! Realm()
    
    init() {
        
        // Check if rooms database exist
        let rooms = realm.objects(RealmRoom.self)
        if rooms.count == 0 || rewriteRooms {
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
        
        // Delete all objects from the realm
        try! realm.write {
            realm.deleteAll()
        }

        // Floor 1
        let room11 = Room(id: 11,
                          enters: [Room.Enter(from: 11, to: 12, point: CGPoint(x: 127, y: 42))],
                          frame: CGRect(x: 129, y: 28, width: 15, height: 55))
        let room12 = Room(id: 12,
                          enters: [Room.Enter(from: 12, to: 11, point: CGPoint(x: 127, y: 42)),
                                   Room.Enter(from: 12, to: 13, point: CGPoint(x: 73, y: 43))],
                          frame: CGRect(x: 73, y: 29, width: 54, height: 33))
        let room13 = Room(id: 13,
                          enters: [Room.Enter(from: 13, to: 12, point: CGPoint(x: 73, y: 43)),
                                   Room.Enter(from: 13, to: 14, point: CGPoint(x: 39, y: 43))],
                          frame: CGRect(x: 41, y: 29, width: 33, height: 33))
        let room14 = Room(id: 14,
                          enters: [Room.Enter(from: 14, to: 13, point: CGPoint(x: 39, y: 43)),
                                   Room.Enter(from: 14, to: 15, point: CGPoint(x: 14, y: 59))],
                          frame: CGRect(x: 5, y: 29, width: 34, height: 29))
        let room15 = Room(id: 15,
                          enters: [Room.Enter(from: 15, to: 14, point: CGPoint(x: 14, y: 59)),
                                   Room.Enter(from: 15, to: 16, point: CGPoint(x: 14, y: 87))],
                          frame: CGRect(x: 5, y: 61, width: 34, height: 26))
        let room16 = Room(id: 16,
                          enters: [Room.Enter(from: 16, to: 15, point: CGPoint(x: 14, y: 87))],
                          frame: CGRect(x: 5, y: 88, width: 34, height: 26))
        
        // Add rooms
        let rooms = [room11, room12, room13, room14, room15, room16]
        try! realm.write {
            for room in rooms {
                realm.add(room.realm())
            }
        }
    }
}
