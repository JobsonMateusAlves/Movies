//
//  Service.swift
//  Movies
//
//  Created by Jobson Mateus on 02/03/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Service {
    
    func getError<T>(response: DataResponse<T>) -> String {
        
        switch self.getStatusCode(response: response) {
        case 200...299:
            return "Ok"
        case 500...599:
            return "Unavailable service"
        case 404:
            return "Not found"
        case -1009:
            return "No internet connection"
        default:
            return "Try again"
        }
    }
    
    func getStatusCode<T>(response: DataResponse<T>) -> Int {
        
        guard let responseHTTP = response.response else {
            
            if let error = response.result.error as? URLError {
                
                return error.errorCode
            }
            
            return 0
        }
        
        return responseHTTP.statusCode
    }
}
