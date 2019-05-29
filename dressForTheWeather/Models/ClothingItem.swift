//
//  ClothingItem.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation
import UIKit

class ClothingItem {
    var name: String
    var placement: [BodyPlacement]
    var tempRange: ClosedRange<Double>
    // TODO: don't force unwrap
    private var fallbackImages: [UIImage] = [UIImage(named: "sparkle1")!,
                                             UIImage(named: "sparkle2")!,
                                             UIImage(named: "sparkle3")!]
    var image: UIImage {
        if let theImage = UIImage(named: name) {
            return theImage
        } else {
            // TODO: don't force unwrap
            return fallbackImages.randomElement()!
        }
    }
    
    init(name: String, placement: [BodyPlacement], tempRange: ClosedRange<Double>) {
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
