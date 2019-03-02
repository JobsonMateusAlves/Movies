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
        self.starButton.setImage(self.movie.favorite ? UIImage(named: "star") : UIImage(named: "emptyStar"), for: .normal)
        self.imageMovie.setImage(self.movie.imagemUrl)
        self.titleLabel.text = self.movie.nome
        self.overViewLabel.text = self.movie.sinopse
    }
    @IBAction func didFavorited(_ sender: Any) {
        
        self.movie = MovieViewModel.favoriteMovie(by: self.movie.id)
        
        self.starButton.setImage(self.movie.favorite ? UIImage(named: "star") : UIImage(named: "emptyStar"), for: .normal)
    }
}
