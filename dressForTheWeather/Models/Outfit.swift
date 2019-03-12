//
//  Outfit.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

struct Outfit {
    
    var components: [ClothingItem]
    
    func outfitString() -> String {
        let componentNames: [String] = components.map { $0.name }
        return componentNames.joined(separator: ", ")
    }
    
}
