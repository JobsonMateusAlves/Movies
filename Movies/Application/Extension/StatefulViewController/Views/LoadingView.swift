//
//  LoadingView.swift
//  Movies
//
//  Created by Jobson Mateus on 01/03/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import UIKit
import Reusable
import SpringIndicator

class LoadingView: UIView, NibOwnerLoadable {

    @IBOutlet weak var viewLoading: SpringIndicator!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
        self.setColors()
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
    }
    
    func configure() {
        
        self.viewLoading.lineColor = Colors.titleColor
        
        self.viewLoading.start()
    }
    
    func setColors(background: UIColor = .black) {
        
        self.backgroundColor = background
    }
}
