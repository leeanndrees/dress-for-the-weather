//
//  Outfit.swift
//  dressForTheWeather
//
//  Created by Elizabeth Levosinski on 4/16/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

struct Outfit {
    
    var components: [ClothingItem]
    
    var recommendations: String {
        let componentNames = components.map { $0.name }
        return componentNames.joined(separator: ", ")
    }
    
}

