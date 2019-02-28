//
//  EmtpyView.swift
//  Movies
//
//  Created by Jobson Mateus on 26/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import UIKit
import Reusable

class EmtpyView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
        self.setTitle(with: "No Content")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
        self.setTitle(with: "No Content")
    }
    
    func setTitle(with text: String) {
        
        self.title.text = text
    }
    
    func setColors(backgroudColor: UIColor = UIColor.black, titleColor: UIColor = UIColor.white) {
        
        self.backgroundColor = backgroundColor
        self.title.textColor = titleColor
    }
}
