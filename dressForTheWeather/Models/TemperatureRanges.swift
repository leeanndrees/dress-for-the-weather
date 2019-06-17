//
//  TemperatureRanges.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 6/17/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

enum TemperatureRanges: String, CaseIterable {
    case veryCold
    case cold
    case sortaCold
    case mild
    case sortaWarm
    case warm
    case veryWarm
    case hot
    case veryHot
    
    var nextTemp: TemperatureRanges {
        switch self {
        case .veryCold: return .cold
        case .cold: return .veryCold
        case .sortaCold: return .cold
        case .mild: return .sortaCold
        case .sortaWarm: return .mild
        case .warm: return .sortaWarm
        case .veryWarm: return .warm
        case .hot: return .veryWarm
        case .veryHot: return .hot
        }
    }
}
