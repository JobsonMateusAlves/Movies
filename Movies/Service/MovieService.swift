//
//  MovieService.swift
//  Movies
//
//  Created by Jobson Mateus on 26/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class MovieService {
    
    var getSearchMoviesRequest: Request?
    
    var delegate: StatefulViewController!
    
    init(delegate: StatefulViewController) {
        
        self.delegate = delegate
    }
    
    func getSearchMovies(text: String) {
        
        self.getSearchMoviesRequest?.cancel()
        
        self.getSearchMoviesRequest = MovieRequestFactory.getSearchMovies(query: text).validate().responseArray(keyPath: "results", completionHandler: { (response: DataResponse<[Movie]>) in
            
            switch response.result {
                
            case .success:
                
                if let movies = response.result.value {
                    
                    MovieViewModel.deleteAll()
                    MovieViewModel.saveAll(movies: movies)
                }
                
                self.delegate.success(.searchMovies)
            case .failure:
                //TODO: ErrorManager
                self.delegate.failure(.searchMovies, error: "")
            }
        })
    }
}
