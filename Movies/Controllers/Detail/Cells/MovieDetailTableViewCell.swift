//
//  MovieDetailTableViewCell.swift
//  Movies
//
//  Created by Jobson Mateus on 28/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import UIKit
import Reusable

protocol MovieDetailTableViewCellDelegate {
    func didFavorited()
}

class MovieDetailTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var delegate: MovieDetailTableViewCellDelegate!
    var movie: MovieView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.setColors()
    }

    func setColors() {
        
        self.backgroundColor = Colors.primaryColor
        self.titleLabel.textColor = Colors.primaryText
        self.overViewLabel.textColor = Colors.primaryText
    }
    
    func bind(with movie: MovieView) {
        
        self.movie = movie
        self.starButton.setImage(self.movie.favorite ? Asset.star.getImage() : Asset.emptyStar.getImage(), for: .normal) //TODO: Placeholder
        self.imageMovie.setImage(self.movie.imagemUrl, placeholder: nil, contentMode: .scaleAspectFit)
        self.backgroundImage.setImage(self.movie.imagemUrl, placeholder: nil) //TODO: Placeholder Image
        self.titleLabel.text = self.movie.nome
        self.overViewLabel.text = self.movie.sinopse
        
        self.setGradientInBackImage()
    }
    
    func setGradientInBackImage() {
        
        let gradientLayer = CAGradientLayer()
        
        let colorBottom = UIColor.gray.withAlphaComponent(0.3).cgColor
        let colorMiddle = UIColor.gray.withAlphaComponent(0.3).cgColor
        
        gradientLayer.frame = self.backgroundImage.bounds
        gradientLayer.colors = [colorMiddle, colorBottom]
        gradientLayer.locations = [0, 0.6]
        
        self.backgroundImage.layer.insertSublayer(gradientLayer, at:0)
    }
    
    @IBAction func didFavorited(_ sender: Any) {
        
        self.movie = MovieViewModel.favoriteMovie(by: self.movie.id)
        
        self.starButton.setImage(self.movie.favorite ? Asset.star.getImage() : Asset.emptyStar.getImage(), for: .normal)
    }
}
