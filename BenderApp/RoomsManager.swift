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
    let currentRoom = 13
    
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
        let room17 = Room(id: 17,
                          enters: [Room.Enter(from: 17, to: 18, point: CGPoint(x: 68, y: 123))],
                          frame: CGRect(x: 51, y: 115, width: 18 , height: 17 ))
        let room18 = Room(id: 18,
                          enters: [Room.Enter(from: 18, to: 19, point: CGPoint(x: 73, y: 130)),
                                   Room.Enter(from: 18, to: 17, point: CGPoint(x: 69, y: 123))],
                          frame: CGRect(x: 69, y: 115, width: 24 , height: 17 ))
        let room19 = Room(id: 19,
                          enters: [Room.Enter(from: 19, to: 18, point: CGPoint(x: 73, y: 130)),
                                   Room.Enter(from: 19, to: 20, point: CGPoint(x: 74, y: 140))],
                          frame: CGRect(x: 69, y: 131, width: 22 , height: 10 ))
        let room20 = Room(id: 20,
                          enters: [Room.Enter(from: 20, to: 21, point: CGPoint(x: 74, y: 162)),
                                   Room.Enter(from: 20, to: 19, point: CGPoint(x: 74, y: 140))],
                          frame: CGRect(x: 69, y: 141, width: 22 , height: 21 ))
        let room21 = Room(id: 21,
                          enters: [Room.Enter(from: 21, to: 20, point: CGPoint(x: 74, y: 162)),
                                   Room.Enter(from: 21, to: 22, point: CGPoint(x: 74, y: 185))],
                          frame: CGRect(x: 61, y: 162, width: 31 , height: 22 ))
        let room22 = Room(id: 22,
                          enters: [Room.Enter(from: 22, to: 23, point: CGPoint(x: 91, y: 200)),
                                   Room.Enter(from: 22, to: 21, point: CGPoint(x: 74, y: 185))],
                          frame: CGRect(x: 61, y: 185, width: 31 , height: 30 ))
        let room23 = Room(id: 23,
                          enters: [Room.Enter(from: 23, to: 22, point: CGPoint(x: 91, y: 200)),
                                   Room.Enter(from: 23, to: 24, point: CGPoint(x: 102, y: 202))],
                          frame: CGRect(x: 91, y: 185, width: 21 , height: 28 ))
        let room24 = Room(id: 24 ,
                          enters: [],
                          frame: CGRect(x: 111, y: 114, width: 15 , height: 158 ))
        let room27 = Room(id: 27 ,
                          enters: [Room.Enter(from: 27, to: 26, point: CGPoint(x: 152, y: 267)),
                                   Room.Enter(from: 27, to: 28, point: CGPoint(x: 151,y: 306))],
                          frame: CGRect(x: 111, y: 266, width: 50 , height: 39 ))
        let room26 = Room(id: 26 ,
                          enters: [Room.Enter(from: 26, to: 27, point: CGPoint(x: 152, y: 267))],
                          frame: CGRect(x: 126, y: 212, width: 33 , height: 54))
        let room28 = Room(id: 28 ,
                          enters: [Room.Enter(from: 28, to: 27, point: CGPoint(x: 151, y: 306)),
                                   Room.Enter(from: 28, to: 29, point: CGPoint(x: 151,y: 337))],
                          frame: CGRect(x: 126, y: 306, width: 32 , height: 32))
        let room29 = Room(id: 29,
                          enters: [Room.Enter(from: 29, to: 28, point: CGPoint(x: 151, y: 337)),
                                   Room.Enter(from: 29, to: 30, point: CGPoint(x: 152, y: 351))],
                          frame: CGRect(x: 127, y: 337, width: 33, height: 15))
        let room30 = Room(id: 30,
                          enters: [Room.Enter(from: 30, to: 29, point: CGPoint(x: 152, y: 351)),
                                   Room.Enter(from: 30, to: 34, point: CGPoint(x:152, y: 366))],
                          frame: CGRect(x: 127, y: 337, width: 33, height: 15))
        let room34 = Room(id: 34,
                          enters: [Room.Enter(from: 34, to: 32, point: CGPoint(x: 152, y: 394)),
                                   Room.Enter(from: 34, to: 30, point: CGPoint(x:152, y: 366))],
                          frame: CGRect(x: 127, y: 366, width: 33, height: 27))
        let room32 = Room(id: 32,
                          enters: [Room.Enter(from: 32, to: 34, point: CGPoint(x: 152, y: 394)),
                                   Room.Enter(from: 32, to: 33, point: CGPoint(x: 126, y: 403))],
                          frame: CGRect(x: 127, y: 395, width: 33, height: 17))
        let room33 = Room(id: 33,
                          enters: [Room.Enter(from: 32, to: 34, point: CGPoint(x: 152, y: 394)),
                                   Room.Enter(from: 32, to: 35, point: CGPoint(x: 126, y: 420))],
                          frame: CGRect(x: 112, y: 308, width: 15, height: 139))
        let room38 = Room(id: 38,
                          enters: [Room.Enter(from: 38, to: 39, point: CGPoint(x: 82, y: 433))],
                          frame: CGRect(x: 68, y: 413, width: 27, height: 20))
        let room39 = Room(id: 39,
                          enters: [Room.Enter(from: 39, to: 38, point: CGPoint(x: 82, y: 433)),
                                   Room.Enter(from: 39, to: 40, point: CGPoint(x: 82, y: 443))],
                          frame: CGRect(x: 68, y: 433, width: 28, height: 10))
        let room40 = Room(id: 40,
                          enters: [Room.Enter(from: 40, to: 46, point: CGPoint(x: 59, y: 450)),
                                   Room.Enter(from: 40, to: 39, point: CGPoint(x: 82, y: 443))],
                          frame: CGRect(x: 59, y: 443, width: 30, height: 22))
        let room46 = Room(id: 46,
                          enters: [Room.Enter(from: 46, to: 40, point: CGPoint(x: 59, y: 450)),
                                   Room.Enter(from: 46, to: 47, point: CGPoint(x: 38, y: 450))],
                          frame: CGRect(x: 38, y: 443, width: 22, height: 12))
        let room47 = Room(id: 47,
                          enters: [Room.Enter(from: 47, to: 48, point: CGPoint(x: 14, y: 455)),
                                   Room.Enter(from: 47, to: 46, point: CGPoint(x: 38, y: 450))],
                          frame: CGRect(x: 3, y: 442, width: 36, height: 14))
        let room48 = Room(id: 48,
                          enters: [Room.Enter(from: 48, to: 47, point: CGPoint(x: 14, y: 455)),
                                   Room.Enter(from: 48, to: 49, point: CGPoint(x: 38, y: 450))],
                          frame: CGRect(x: 3, y: 454, width: 34, height: 29))
        let room49 = Room(id: 49,
                          enters: [Room.Enter(from: 49, to: 50, point: CGPoint(x: 14, y: 513)),
                                   Room.Enter(from: 49, to: 48, point: CGPoint(x: 38, y: 450))],
                          frame: CGRect(x: 3, y: 483, width: 45, height: 30))
        let room50 = Room(id: 50,
                          enters: [Room.Enter(from: 50, to: 49, point: CGPoint(x: 14, y: 513)),
                                   Room.Enter(from: 50, to: 51, point: CGPoint(x: 19, y: 531))],
                          frame: CGRect(x: 3, y: 513, width: 15, height: 26))
        let room51 = Room(id: 51,
                          enters: [Room.Enter(from: 51, to: 52, point: CGPoint(x: 47, y: 532)),
                                   Room.Enter(from: 51, to: 50, point: CGPoint(x: 19, y: 531))],
                          frame: CGRect(x: 18, y: 513, width: 29, height: 25))
        let room52 = Room(id: 52,
                          enters: [Room.Enter(from: 52, to: 51, point: CGPoint(x: 47, y: 532)),
                                   Room.Enter(from: 52, to: 53, point: CGPoint(x: 63, y: 543))],
                          frame: CGRect(x: 48, y: 526, width: 15, height: 26))
        let room53 = Room(id: 53,
                          enters: [Room.Enter(from: 53, to: 54, point: CGPoint(x: 82, y: 542)),
                                   Room.Enter(from: 53, to: 52, point: CGPoint(x: 63, y: 543))],
                          frame: CGRect(x: 62, y: 526, width: 19, height: 26))
        let room54 = Room(id: 54,
                          enters: [Room.Enter(from: 54, to: 53, point: CGPoint(x: 82, y: 542))],
                          frame: CGRect(x: 82, y: 526, width: 17, height: 27))
        let room69 = Room(id: 69,
                          enters: [Room.Enter(from: 69, to: 68, point: CGPoint(x: 120, y: 541))],
                          frame: CGRect(x: 98, y: 513, width: 27, height: 19))
        let room68 = Room(id: 68,
                          enters: [Room.Enter(from: 68, to: 69, point: CGPoint(x: 120, y: 541))],
                          frame: CGRect(x: 112, y: 482, width: 13, height: 31))
        let room55 = Room(id: 55,
                          enters: [Room.Enter(from: 55, to: 33, point: CGPoint(x: 126, y: 420)),
                                   Room.Enter(from: 55, to: 56, point: CGPoint(x: 146, y: 420))],
                          frame: CGRect(x: 126, y: 411, width: 20, height: 33))
        let room56 = Room(id: 56,
                          enters: [Room.Enter(from: 56, to: 55, point: CGPoint(x: 146, y: 420))],
                          frame: CGRect(x: 146, y: 411, width: 34, height: 32))
        let room57 = Room(id: 57,
                          enters: [Room.Enter(from: 57, to: 61, point: CGPoint(x: 185, y: 493))],
                          frame: CGRect(x: 180, y: 411, width: 12, height: 84))
        let room58 = Room(id: 58,
                          enters: [Room.Enter(from: 58, to: 59, point: CGPoint(x: 198, y: 447))],
                          frame: CGRect(x: 192, y: 411, width: 13, height: 36))
        let room59 = Room(id: 59,
                          enters: [Room.Enter(from: 59, to: 58, point: CGPoint(x: 198, y: 447)),
                                   Room.Enter(from: 59, to: 60, point: CGPoint(x: 198, y: 469))],
                          frame: CGRect(x: 191, y: 447, width: 13, height: 23))
        let room60 = Room(id: 60,
                          enters: [Room.Enter(from: 60, to: 61, point: CGPoint(x: 198, y: 493)),
                                   Room.Enter(from: 60, to: 59, point: CGPoint(x: 198, y: 469))],
                          frame: CGRect(x: 191, y: 469, width: 13, height: 24))
        let room61 = Room(id: 61,
                          enters: [Room.Enter(from: 61, to: 60, point: CGPoint(x: 198, y: 493)),
                                   Room.Enter(from: 61, to: 62, point: CGPoint(x: 204, y: 502))],
                          frame: CGRect(x: 178, y: 493, width: 26, height: 46))
        let room62 = Room(id: 62,
                          enters: [Room.Enter(from: 62, to: 63, point: CGPoint(x: 233, y: 501)),
                                   Room.Enter(from: 62, to: 61, point: CGPoint(x: 204, y: 502))],
                          frame: CGRect(x: 233, y: 496, width: 22, height: 31))
        let room91 = Room(id: 91,
                          enters: [Room.Enter(from: 91, to: 89, point: CGPoint(x: 515, y: 427))],
                          frame: CGRect(x: 478, y: 413, width: 37, height: 22))
        let room89 = Room(id: 89,
                          enters: [Room.Enter(from: 89, to: 91, point: CGPoint(x: 515, y: 427))],
                          frame: CGRect(x: 515, y: 413, width: 25, height: 29))
        let room90 = Room(id: 90,
                          enters: [],
                          frame: CGRect(x: 557, y: 392, width: 24, height: 43))
        let room100 = Room(id: 100,
                           enters: [],
                           frame: CGRect(x: 553, y: 255, width: 93, height: 70))
        let room101 = Room(id: 101,
                           enters: [],
                           frame: CGRect(x: 645, y: 255, width: 42, height: 68))
        let room102 = Room(id: 102,
                           enters: [],
                           frame: CGRect(x: 690, y: 275, width: 109, height: 30))
        let room106 = Room(id: 106,
                           enters: [Room.Enter(from: 106, to: 128, point: CGPoint(x: 832, y: 275)),
                                    Room.Enter(from: 106, to: 107, point: CGPoint(x: 832, y: 304))],
                           frame: CGRect(x: 800, y: 274, width: 46, height: 31))
        let room107 = Room(id: 107,
                           enters: [Room.Enter(from: 107, to: 108, point: CGPoint(x: 833, y: 409)),
                                    Room.Enter(from: 107, to: 106, point: CGPoint(x: 832, y: 304))],
                           frame: CGRect(x: 809, y: 305, width: 49, height: 103))
        let room108 = Room(id: 108,
                           enters: [Room.Enter(from: 108, to: 107, point: CGPoint(x: 833, y: 409)),
                                    Room.Enter(from: 108, to: 109, point: CGPoint(x: 859, y: 440))],
                           frame: CGRect(x: 803, y: 408, width: 54, height: 63))
        let room109 = Room(id: 109,
                           enters: [Room.Enter(from: 109, to: 110, point: CGPoint(x: 935, y: 439)),
                                    Room.Enter(from: 109, to: 108, point: CGPoint(x: 859, y: 440))],
                           frame: CGRect(x: 859, y: 420, width: 78, height: 45))
        let room110 = Room(id: 110,
                           enters: [Room.Enter(from: 110, to: 109, point: CGPoint(x: 935, y: 439)),
                                    Room.Enter(from: 110, to: 111, point: CGPoint(x: 992, y: 440))],
                           frame: CGRect(x: 935, y: 420, width: 57, height: 42))
        let room111 = Room(id: 111,
                           enters: [Room.Enter(from: 111, to: 112, point: CGPoint(x: 1063, y: 439)),
                                    Room.Enter(from: 111, to: 110, point: CGPoint(x: 992, y: 440))],
                           frame: CGRect(x: 991, y: 420, width: 72, height: 43))
        let room112 = Room(id: 112,
                           enters: [Room.Enter(from: 112, to: 111, point: CGPoint(x: 1063, y: 439)),
                                    Room.Enter(from: 112, to: 113, point: CGPoint(x: 1096, y: 420))],
                           frame: CGRect(x: 1063, y: 420, width: 63, height: 51))
        let room113 = Room(id: 113,
                           enters: [Room.Enter(from: 113, to: 114, point: CGPoint(x: 1087, y: 390)),
                                    Room.Enter(from: 113, to: 112, point: CGPoint(x: 1096, y: 420))],
                           frame: CGRect(x: 1063, y: 390, width: 61, height: 31))
        let room114 = Room(id: 114,
                           enters: [Room.Enter(from: 114, to: 113, point: CGPoint(x: 1087, y: 390))],
                           frame: CGRect(x: 1063, y: 303, width: 42, height: 87))
        let room115 = Room(id: 115,
                           enters: [],
                           frame: CGRect(x: 994, y: 275, width: 111, height: 29))
        let room116 = Room(id: 116,
                           enters: [Room.Enter(from: 116, to: 117, point: CGPoint(x: 1015, y: 255))],
                           frame: CGRect(x: 1015, y: 232, width: 90, height: 42))
        let room117 = Room(id: 117,
                           enters: [Room.Enter(from: 117, to: 116, point: CGPoint(x: 1015, y: 255)),
                                    Room.Enter(from: 117, to: 121, point: CGPoint(x: 993, y: 255))],
                           frame: CGRect(x: 994, y: 233, width: 21, height: 42))
        let room121 = Room(id: 121,
                           enters: [Room.Enter(from: 121, to: 127, point: CGPoint(x: 932, y: 221)),
                                    Room.Enter(from: 121, to: 117, point: CGPoint(x: 993, y: 255))],
                           frame: CGRect(x: 932, y: 207, width: 61, height: 67))
        let room127 = Room(id: 127,
                           enters: [Room.Enter(from: 127, to: 121, point: CGPoint(x: 932, y: 221)),
                                    Room.Enter(from: 127, to: 129, point: CGPoint(x: 848, y: 221))],
                           frame: CGRect(x: 847, y: 209, width: 85, height: 23))
        let room129 = Room(id: 129,
                           enters: [Room.Enter(from: 129, to: 128, point: CGPoint(x: 826, y: 231)),
                                    Room.Enter(from: 129, to: 127, point: CGPoint(x: 848, y: 221)),
                                    Room.Enter(from: 129, to: 130, point: CGPoint(x: 832, y: 208))],
                           frame: CGRect(x: 801, y: 208, width: 46, height: 24))
        let room128 = Room(id: 128,
                           enters: [Room.Enter(from: 128, to: 129, point: CGPoint(x: 826, y: 231)),
                                    Room.Enter(from: 128, to: 106, point: CGPoint(x: 831, y: 275))],
                           frame: CGRect(x: 801, y: 231, width: 47, height: 44))
        let room130 = Room(id: 130,
                           enters: [Room.Enter(from: 130, to: 129, point: CGPoint(x: 832, y: 208)),
                                    Room.Enter(from: 130, to: 131, point: CGPoint(x: 844, y: 97))],
                           frame: CGRect(x: 809, y: 97, width: 49, height: 111))
        let room131 = Room(id: 131,
                           enters: [Room.Enter(from: 131, to: 130, point: CGPoint(x: 844, y: 97))],
                           frame: CGRect(x: 841, y: 61, width: 33, height: 37))
        
        // Add rooms
        let rooms = [room11, room12, room13, room14, room15, room16, room17, room18, room19, room20, room21, room22, room23, room24, room26, room27, room28, room29, room30, room32, room33, room34, room38, room39, room40, room46, room47, room48, room49, room50, room51, room52, room53, room54, room55, room56, room57, room58, room60, room61, room62, room68, room89, room90, room91, room100, room101, room102, room106, room107, room108, room109, room110, room111, room112, room113, room114, room115, room121, room127, room129, room128, room130, room131]
        try! realm.write {
            for room in rooms {
                realm.add(room.realm())
            }
        }
    }
}
