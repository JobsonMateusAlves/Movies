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
        self.starButton.setImage(self.movie.favorite ? Asset.star.getImage() : Asset.emptyStar.getImage(), for: .normal)
        self.imageMovie.setImage(self.movie.imagemUrl, placeholder: Asset.moviePlaceholder.getImage(), contentMode: .scaleAspectFit)
        self.backgroundImage.setImage(self.movie.imagemUrl, placeholder: Asset.moviePlaceholder.getImage())
        self.titleLabel.text = self.movie.nome
        self.overViewLabel.text = self.movie.sinopse
        
        self.imageMovie.hero.id = "\(movie.id)"
        self.imageMovie.hero.modifiers = [.zPosition(100)]
        self.hero.isEnabled = true
        
        self.backgroundImage.hero.id = "\(movie.id) - background"
        self.backgroundImage.hero.modifiers = [.zPosition(100)]
    }
    
    @IBAction func didFavorited(_ sender: Any) {
        
        self.movie = MovieViewModel.favoriteMovie(by: self.movie.id)
        
        self.starButton.setImage(self.movie.favorite ? Asset.star.getImage() : Asset.emptyStar.getImage(), for: .normal)
    }
}
