//
//  TemperatureRanges.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 6/17/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

enum TemperatureRanges: String {
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
    
    static func from(temp: Double) -> TemperatureRanges {
        switch temp {
        case -20...15: return .veryCold
        case 16...35: return .cold
        case 36...50: return .sortaCold
        case 51...64: return .mild
        case 65...72: return .sortaWarm
        case 68...77: return .warm
        case 78...83: return .veryWarm
        case 84...92: return .hot
        case 93...120: return .veryHot
        default: return .mild
        }
    }
}
