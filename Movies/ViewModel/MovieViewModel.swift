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
    var sinopse = "Without overview"
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
        
        for movie in movies {
            
            let movieView = self.get(by: movie.id.value ?? -1)
            movie.favorite.value = movieView.favorite
        }
        
        try! uiRealm.write {
            
            uiRealm.add(movies, update: true)
        }
    }
    
    static func getModel(by id: Int) -> Movie? {
        
        return uiRealm.object(ofType: Movie.self, forPrimaryKey: id)
    }

    static func getAsView(movie: Movie?) -> MovieView {
        
        guard let movie = movie else {
            return MovieView()
        }
        
        var movieView = MovieView()
        
        movieView.id = movie.id.value ?? 0
        movieView.nome = movie.nome ?? ""
        movieView.imagem = movie.imagem ?? ""
        movieView.video = movie.video.value ?? false
        movieView.originalTitle = movie.originalTitle ?? ""
        movieView.favorite = movie.favorite.value ?? false
        
        if let sinopse = movie.sinopse, sinopse != "" {
            
            movieView.sinopse = sinopse
        }
        
        return movieView
    }
    
    static func getAsView(sequence: [Movie]) -> [MovieView] {
        
        var moviesView: [MovieView] = []
        
        for movie in sequence {
            moviesView.append(self.getAsView(movie: movie))
        }
        
        return moviesView
    }
    
    static func get() -> [Movie] {
        
        let objects = uiRealm.objects(Movie.self).sorted(byKeyPath: "nome")
        
        var movies: [Movie] = []
        movies.append(contentsOf: objects)
        
        return movies
    }
    
    static func getAll() -> [MovieView] {
        
        return self.getAsView(sequence: self.get())
    }
    
    static func getFavorites() -> [MovieView] {
        
        return self.getAll().filter({$0.favorite})
    }
    
    static func get(by text: String) -> [MovieView] {
        
        
        return self.getAll().filter({$0.nome.uppercased().trim().diacriticInsensitive().contains(text.uppercased().trim().diacriticInsensitive())})
    }
    
    static func get(by id: Int) -> MovieView {
        
        let object = uiRealm.object(ofType: Movie.self, forPrimaryKey: id)
        
        return self.getAsView(movie: object)
    }
    
    static func deleteAll() {
        
        let objects = self.get().filter { (movie) -> Bool in
            
            if let favorite = movie.favorite.value {
                
                return !favorite
            }
            return true
        }
        
        try! uiRealm.write {
            
            uiRealm.delete(objects)
        }
    }
    
    static func favoriteMovie(by id: Int) -> MovieView {
        
        let movie = uiRealm.object(ofType: Movie.self, forPrimaryKey: id)!
        
        if let favorite = movie.favorite.value {
            try! uiRealm.write {
                
                movie.favorite.value = !favorite
            }
        }
        return self.getAsView(movie: movie)
    }
}
