//
//  ImageAsset.swift
//  Movies
//
//  Created by Jobson Mateus on 01/03/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation
import UIKit

extension ImageAsset {
    
    func getImage() -> UIImage {
        
        return UIImage.init(asset: self)
    }
}
