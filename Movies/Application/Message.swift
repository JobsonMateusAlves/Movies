//
//  Message.swift
//  Movies
//
//  Created by Jobson Mateus on 02/03/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation
import SwiftMessages
import UIKit

class Message {
    
    var messageConfiguration = SwiftMessages.Config()
    let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
    
    
    init(text: String?, target: ViewController, presentationStyle: SwiftMessages.PresentationStyle = .bottom) {
        
        messageConfiguration.presentationContext = .viewController(target)
        messageConfiguration.presentationStyle = presentationStyle
        
        self.view.titleLabel?.text = "Error"
        self.view.bodyLabel?.text = text ?? "Something wrong"
        self.view.bodyLabel?.textColor = .white
        self.view.bodyLabel?.numberOfLines = 0
        
        self.view.iconImageView?.isHidden = true
        self.view.button?.isHidden = true
        
        self.view.configureTheme(.error)
    }
    
    func show() {
        
        SwiftMessages.show(config: self.messageConfiguration, view: self.view)
    }
}
