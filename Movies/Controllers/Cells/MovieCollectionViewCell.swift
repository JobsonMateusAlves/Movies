//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Jobson Mateus on 27/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func bind(movie: MovieView) {
        
        self.movieImage.setImage(movie.imagemUrl)
    }
}
