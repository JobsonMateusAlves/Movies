//
//  StatefulViewControllerDelegate.swift
//  Movies
//
//  Created by Jobson Mateus on 01/03/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation
import UIKit

extension StatefulViewController {
    
    func setupInitialViewState(emptyText: String = L10n.EmptyText.default, completion: (() -> Void)? = nil) {
        
        self.emptyView = EmptyView(frame: .zero, emptyText: emptyText)
        self.loadingView = LoadingView(frame: .zero)
        
        self.setupInitialViewState(completion)
    }
    
    func update(emptyText: String) {
        
        if let emptyView = self.emptyView as? EmptyView {
            
            emptyView.emptyText.text = emptyText
        }
    }
}
