//
//  TraillerTableViewCell.swift
//  Movies
//
//  Created by Jobson Mateus on 28/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import UIKit
import Reusable

protocol TrailerTableViewCellDelegate {
    func openTrailler()
}

class TrailerTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var trailerButton: UIButton!
    
    var delegate: TrailerTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setColors()
    }
    
    func setColors() {
        
        self.backgroundColor = Colors.primaryColor
    }
    
    func bind(text: String) {
        
        self.trailerButton.setTitle(text, for: .normal)
    }
    
    @IBAction func openTrailer(_ sender: Any) {
        
        self.delegate.openTrailler()
    }
}
