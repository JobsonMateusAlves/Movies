//
//  Movie.swift
//  Movies
//
//  Created by Jobson Mateus on 26/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift


class Movie: Object, Mappable {

    var id = RealmOptional<Int>()
    @objc dynamic var nome: String?
    @objc dynamic var sinopse: String?
    @objc dynamic var imagem: String?
    @objc dynamic var trailer: String?
    @objc dynamic var originalTitle: String?
    var video = RealmOptional<Bool>()
    var favorite = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        
        return "id"
    }
    
    func mapping(map: Map) {
        
        self.id.value           <- map["id"]
        self.nome               <- map["title"]
        self.sinopse            <- map["overview"]
        self.imagem             <- map["poster_path"]
        self.trailer            <- map[""]
        self.video.value        <- map["video"]
        self.originalTitle      <- map["originalTitle"]
    }
}
