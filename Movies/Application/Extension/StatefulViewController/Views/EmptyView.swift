//
//  EmptyView.swift
//  Movies
//
//  Created by Jobson Mateus on 01/03/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import UIKit
import Reusable

class EmptyView: UIView, NibOwnerLoadable {

    @IBOutlet weak var emptyText: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
        self.setColors()
        self.emptyText.text = "No content"
    }
    
    init(frame: CGRect, emptyText: String) {
        super.init(frame: frame)
        self.loadNibContent()
        self.setColors()
        self.emptyText.text = emptyText
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
        self.setColors()
        self.emptyText.text = "No content"
    }
    
    func setColors(backgroud: UIColor = .black, titleColor: UIColor = Colors.primaryText) {
        
        self.backgroundColor = .clear
        self.emptyText.textColor = titleColor
    }
}
