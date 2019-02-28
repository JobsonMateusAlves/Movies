//
//  MovieRequestFactory.swift
//  Movies
//
//  Created by Jobson Mateus on 26/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class MovieRequestFactory {
    
    static func getSearchMovies(query: String) -> DataRequest {
        
        let params: Parameters = ["query": query, "api_key": apiKey]
        
        return AF.request(baseURL + "/search/movie", method: .get, parameters: params)
    }
}
