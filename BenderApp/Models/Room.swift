//
//  Room.swift
//  BenderApp
//
//  Created by bestK1ng on 21/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class Room {

    let id: Int
    let enters: [Int: Int]
    let frame: CGRect
    
    init(id: Int, enters: [Int: Int], frame: CGRect) {
        self.id = id
        self.enters = enters
        self.frame = frame
    }
}
