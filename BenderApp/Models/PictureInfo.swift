//
//  PictureInfo.swift
//  BenderApp
//
//  Created by a.belkov on 22/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import Foundation

class PictureInfo {
    
    var id: String?
    
    var title: String?
    var country: String?
    var time: String?
    var material: String?
    var technic: String?
    var size: String?
    var category: String?
    var collection: String?
    
    var room: Int?
    var imageURL: URL?
    
    init(dictionary: Dictionary<String, Any?>) {
        
        self.id = dictionary["Инвентарный_номер"] as? String
        self.title = dictionary["Название"] as? String
        self.country = dictionary["Место_создания"] as? String
        self.time = dictionary["Время_создания"] as? String
        self.material = dictionary["Материал"] as? String
        self.technic = dictionary["Техника"] as? String
        self.size = dictionary["Размеры"] as? String
        self.category = dictionary["Категория"] as? String
        self.collection = dictionary["Коллекция"] as? String
        self.room = 0
        self.imageURL = nil
    }
}
