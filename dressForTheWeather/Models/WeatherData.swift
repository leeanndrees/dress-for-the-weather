//
//  WeatherData.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/8/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let latitude: Double
    let longitude: Double
    let currently: Currently
}

struct Currently: Decodable {
    let time: Int
    let summary: String
    let icon: String
    let nearestStormDistance: Double
    let nearestStormBearing: Double
    let precipIntensity: Double
    let precipProbability: Double
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Double
    let cloudCover: Double
    let uvIndex: Double
    let visibility: Double
    let ozone: Double
}
