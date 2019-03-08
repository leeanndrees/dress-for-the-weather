//
//  OutfitStrings.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

func outfitString(from outfit: Outfit) -> String {
    var componentNames: [String] = []
    for component in outfit.components {
        componentNames.append(component.name)
    }
    return componentNames.joined(separator: ", ")
}
