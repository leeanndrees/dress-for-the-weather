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
    let daily: Daily
}

struct Currently: Decodable {
    let temperature: Double
}

struct Daily: Decodable {
    let data: [DailyData]
}

struct DailyData: Decodable {
    let temperatureHigh: Double
    let temperatureLow: Double
}
