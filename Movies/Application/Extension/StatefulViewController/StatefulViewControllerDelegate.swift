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
    
    func setupInitialViewState(emptyText: String, completion: (() -> Void)? = nil) {
        
        self.emptyView = EmptyView(frame: .zero, emptyText: emptyText)
        
        self.setupInitialViewState(completion)
    }
}
