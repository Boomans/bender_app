//
//  Room.swift
//  BenderApp
//
//  Created by bestK1ng on 21/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class Room {
    
    struct Enter {
        let from: Int
        let to: Int
        let point: CGPoint
        
        init(from: Int, to: Int, point: CGPoint) {
            self.from = from
            self.to = to
            self.point = point
        }
        
        init(from: Int, realm: RealmEnter) {
            self.init(from: from, to: realm.to, point: CGPoint(x: CGFloat(realm.pointX), y: CGFloat(realm.pointY)))
        }
        
        func realm() -> RealmEnter {
            
            let realm = RealmEnter()
            
            realm.to = self.to
            realm.pointX = Float(self.point.x)
            realm.pointY = Float(self.point.y)
            
            return realm
        }
    }
    
    let id: Int
    let enters: [Enter]
    let frame: CGRect
    
    init(id: Int, enters: [Enter], frame: CGRect) {
        self.id = id
        self.enters = enters
        self.frame = frame
    }
}

extension Room {
    
    convenience init(realm: RealmRoom) {
        
        var enters: [Enter] = []
        
        // Enters
        
        for (_, realmEnter) in realm.enters.enumerated() {
            let enter = Enter(from: realm.id, realm: realmEnter)
            enters.append(enter)
        }
        
        // Frame
        let frame = CGRect(x: CGFloat(realm.framePointX),
                           y: CGFloat(realm.framePointY),
                           width: CGFloat(realm.frameWidth),
                           height: CGFloat(realm.frameHeight))
        
        self.init(id: realm.id, enters: enters, frame: frame)
    }
    
    func realm() -> RealmRoom {
        
        let realm = RealmRoom()
        
        // ID
        realm.id = self.id
        
        // Enters
        for enter in enters {
            realm.enters.append(enter.realm())
        }
        
        // Frame
        realm.framePointX = Float(self.frame.origin.x)
        realm.framePointY = Float(self.frame.origin.y)
        realm.frameWidth = Float(self.frame.width)
        realm.frameHeight = Float(self.frame.height)
        
        return realm
    }
}
