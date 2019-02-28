//
//  ImageView.swift
//  Movies
//
//  Created by Jobson Mateus on 27/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation
import Kingfisher

extension ImageView {
    
    func setImage(_ url: URL?, placeholder: UIImage? = nil, contentMode: UIViewContentMode = .scaleAspectFill) {
        
        self.layer.masksToBounds = true
        
        self.contentMode = contentMode
        
        let processor = ResizingImageProcessor(referenceSize: self.frame.size, mode: .aspectFill)
        
        self.kf.setImage(with: url, placeholder: placeholder, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(0.2))])
    }
}
