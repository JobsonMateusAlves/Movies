//
//  String.swift
//  Movies
//
//  Created by Jobson Mateus on 28/02/19.
//  Copyright © 2019 Jobson Mateus. All rights reserved.
//

import Foundation

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    func diacriticInsensitive() -> String {
        return self.folding(options: .diacriticInsensitive, locale: Locale.current)
    }
}
