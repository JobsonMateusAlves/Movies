//
//  Trailer.swift
//  Movies
//
//  Created by Jobson Mateus on 01/03/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Trailer: Object, Mappable {
    
    @objc dynamic var id: String?
    @objc dynamic var key: String?
    @objc dynamic var name: String?
    @objc dynamic var site: String?
    var movieId = RealmOptional<Int>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        
        return "id"
    }
    
    func mapping(map: Map) {
        
        self.id                 <- map["id"]
        self.name               <- map["name"]
        self.key                <- map["key"]
        self.site               <- map["site"]
    }
}
