//
//  WeatherData.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/8/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    var latitude: Double
    var longitude: Double
    let currently: Currently
}

struct Currently: Decodable {
    let temperature: Double
}
