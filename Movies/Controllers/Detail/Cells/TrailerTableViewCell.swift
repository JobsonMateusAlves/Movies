//
//  TrailerTableViewCell.swift
//  Movies
//
//  Created by Jobson Mateus on 28/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import UIKit
import Reusable

protocol TrailerTableViewCellDelegate {
    func openTrailer(id: String)
}

class TrailerTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var trailerButton: UIButton!
    
    var delegate: TrailerTableViewCellDelegate!
    
    var trailer: TrailerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setColors()
    }
    
    func setColors() {
        
        self.backgroundColor = Colors.primaryColor
    }
    
    func bind(trailer: TrailerView) {
        
        self.trailer = trailer
        
        self.trailerButton.setTitle(self.trailer.name, for: .normal)
    }
    
    @IBAction func openTrailer(_ sender: Any) {
        
        self.delegate.openTrailer(id: self.trailer.id)
    }
}
