//
//  WeatherNetworking.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation
import UIKit

class WeatherNetworking {
    
    // MARK: - Properties
    
    static let weatherSession = URLSession(configuration: .default)
    static var dataTask: URLSessionDataTask?
    static private var apiKey = "" // add back in apikey
    
    // MARK: - Methods
    
    static func getWeather(completion: (@escaping (WeatherData) -> Void)) {
        dataTask?.cancel()
        
        guard let urlComponents = URLComponents(string: "https://api.darksky.net/forecast/\(apiKey)/37.8267,-122.4233"),
              let url = urlComponents.url else { return }
        
        dataTask = weatherSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                guard let newWeatherData = self.converted(from: data) else { return }
                completion(newWeatherData)
            }
        }
        
        dataTask?.resume()
    }

    static private func converted(from data: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(WeatherData.self, from: data)
            return response
        } catch {
            return nil // TODO: add error handling
        }
    }
    
}
