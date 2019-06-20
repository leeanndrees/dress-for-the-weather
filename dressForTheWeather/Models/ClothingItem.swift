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
    
    var image: UIImage? {
        guard let theImage = UIImage(named: name) else { return fallbackImage }
        return theImage
    }
    
    private let fallbackImageNames = ["sparkle1", "sparkle2", "sparkle3"]
    
    private var fallbackImage: UIImage? {
        guard let imageName = fallbackImageNames.randomElement() else { return nil }
        return UIImage(named: imageName)
    }
    
    init(name: String, placement: [BodyPlacement], tempRange: ClosedRange<Double>) {
        self.name = name
        self.placement = placement
        self.tempRange = tempRange
    }
    
}
