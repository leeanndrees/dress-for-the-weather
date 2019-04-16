//
//  WeatherNetworking.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation
import UIKit

final class WeatherNetworking {
    
    // MARK: - Properties
    
    static let weatherSession = URLSession(configuration: .default)
    static var dataTask: URLSessionDataTask?
   // static private var apiKey = "" // add back in apikey
    
    // MARK: - Methods
    
    static func getWeatherFor(latitude: Double, longitude: Double, completion: (@escaping (WeatherData) -> Void)) {
        dataTask?.cancel()
        
        let darkSkyKey = "e3c6c3f5254ee83b29cf829a4eee5c46"
        
        guard let urlComponents = URLComponents(string: "https://api.darksky.net/forecast/\(darkSkyKey)/\(latitude),\(longitude)"),
            let url = urlComponents.url else {
            return
        }
        
        dataTask = weatherSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
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
