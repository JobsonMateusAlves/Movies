//
//  ViewModel.swift
//  Movies
//
//  Created by Jobson Mateus on 26/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation
import RealmSwift

struct MovieView {
    
    var id = 0
    var nome = ""
    var sinopse = ""
    var imagem = ""
    var trailer = ""
    var originalTitle = ""
    var video = false
    var favorite = false
    
    var imagemUrl: URL? {
        
        return URL(string: imageBaseURL + self.imagem)
    }
}

class MovieViewModel {
    
    static func saveAll(movies: [Movie]) {
        
        try! uiRealm.write {
            
            uiRealm.add(movies, update: true)
        }
    }
    
    static func save(movie: Movie) {
        
        try! uiRealm.write {
            
            uiRealm.add(movie, update: true)
        }
    }
    
    static func getAsView(movie: Movie?) -> MovieView {
        
        guard let movie = movie else {
            return MovieView()
        }
        
        var movieView = MovieView()
        
        movieView.id = movie.id.value ?? 0
        movieView.nome = movie.nome ?? ""
        movieView.sinopse = movie.sinopse ?? ""
        movieView.imagem = movie.imagem ?? ""
        movieView.trailer = movie.trailer ?? ""
        movieView.video = movie.video.value ?? false
        movieView.originalTitle = movie.originalTitle ?? ""
        movieView.favorite = movie.favorite
        
        return movieView
    }
    
    static func getAsView(sequence: [Movie]) -> [MovieView] {
        
        var moviesView: [MovieView] = []
        
        for movie in sequence {
            moviesView.append(self.getAsView(movie: movie))
        }
        
        return moviesView
    }
    
    static func getAll() -> [MovieView] {
        
        let objects = uiRealm.objects(Movie.self)
        
        var movies: [Movie] = []
        movies.append(contentsOf: objects)
        
        return self.getAsView(sequence: movies)
    }
    
    static func get(by id: Int) -> MovieView {
        
        let object = uiRealm.object(ofType: Movie.self, forPrimaryKey: id)
        
        return self.getAsView(movie: object)
    }
    
    static func deleteAll() {
        
        try! uiRealm.write {
            
            uiRealm.delete(uiRealm.objects(Movie.self))
        }
    }
}
