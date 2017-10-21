//
//  RealmRoom.swift
//  BenderApp
//
//  Created by bestK1ng on 21/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit
import RealmSwift

class RealmEnter: Object {
    
    @objc dynamic var to: Int = 0
    @objc dynamic var pointX: Float = 0
    @objc dynamic var pointY: Float = 0
}

class RealmRoom: Object {

    // ID
    @objc dynamic var id = 0
    
    // Enters
    let enters = List<RealmEnter>()
    
    // Frame
    @objc dynamic var framePointX: Float = 0
    @objc dynamic var framePointY: Float = 0
    @objc dynamic var frameWidth: Float = 0
    @objc dynamic var frameHeight: Float = 0
}
