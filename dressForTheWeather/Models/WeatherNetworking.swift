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
    let weatherSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getWeather() {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: "https://api.darksky.net/forecast/\(darkSkyKey)/37.8267,-122.4233") {
//            urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
            guard let url = urlComponents.url else { return }
            dataTask = weatherSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                if let error = error {
//                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    let newWeatherData = self.converted(from: data)
                    DispatchQueue.main.async {
//                        completion(self.tracks, self.errorMessage)
                    }
                }
            }
            dataTask?.resume()
        }
    }

    func converted(from data: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(WeatherData.self, from: data)
            return response
        } catch {
            return nil
        }
    }
    
    
}
