//
//  ClothingItem.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

class ClothingItem {
    var name: String
    var placement: [bodyPlacement]
    var tempRange: ClosedRange<Int>
    
    init(name: String, placement: [bodyPlacement], tempRange: ClosedRange<Int>) {
        self.name = name
        self.placement = placement
        self.tempRange = tempRange
    }
    
    func tooCold() {
        let newLowerBound = tempRange.lowerBound + 5
        self.tempRange = newLowerBound...self.tempRange.upperBound
    }
    
    func tooHot() {
        let newUpperBound = tempRange.upperBound - 5
        self.tempRange = self.tempRange.lowerBound...newUpperBound
    }
}


