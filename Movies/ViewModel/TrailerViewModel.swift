//
//  TrailerViewModel.swift
//  Trailers
//
//  Created by Jobson Mateus on 01/03/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

struct TrailerView {
    
    var id = ""
    var name = ""
    var key = ""
    var site = ""
    var movieId = 0
}

class TrailerViewModel {
    
    static func saveAll(trailers: [Trailer]) {
        
        try! uiRealm.write {
            
            uiRealm.add(trailers, update: true)
        }
    }
    
    static func getModel(by id: Int) -> Trailer? {
        
        return uiRealm.object(ofType: Trailer.self, forPrimaryKey: id)
    }
    
    static func getAsView(trailer: Trailer?) -> TrailerView {
        
        guard let trailer = trailer else {
            return TrailerView()
        }
        
        var trailerView = TrailerView()
        
        trailerView.id = trailer.id ?? ""
        trailerView.name = trailer.name ?? ""
        trailerView.key = trailer.key ?? ""
        trailerView.site = trailer.site ?? ""
        trailerView.movieId = trailer.movieId.value ?? 0
        
        return trailerView
    }
    
    static func getAsView(sequence: [Trailer]) -> [TrailerView] {
        
        var trailersView: [TrailerView] = []
        
        for trailer in sequence {
            trailersView.append(self.getAsView(trailer: trailer))
        }
        
        return trailersView
    }
    
    static func get() -> [Trailer] {
        
        let objects = uiRealm.objects(Trailer.self).sorted(byKeyPath: "name")
        
        var trailers: [Trailer] = []
        trailers.append(contentsOf: objects)
        
        return trailers
    }
    
    static func getAll() -> [TrailerView] {
        
        return self.getAsView(sequence: self.get())
    }
    
    static func get(by id: String) -> TrailerView {
        
        let object = uiRealm.object(ofType: Trailer.self, forPrimaryKey: id)
        
        return self.getAsView(trailer: object)
    }
    
    static func deleteAll() {
        
        let objects = self.get()
        
        try! uiRealm.write {
            
            uiRealm.delete(objects)
        }
    }
}

