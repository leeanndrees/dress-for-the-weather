//
//  RecommendationViewModel.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - Delegate Protocol

protocol RecommendationViewDelegate: AnyObject {
    func didGetWeather(_ weather: String)
    func didGetRecommendations(_ recommendations: String)
    func didFailToGetWeather(_ description: String)
}

final class RecommendationViewModel {
    
    // MARK: - Properties
    
    weak var delegate: RecommendationViewDelegate?
    private var temperature: Double = 0 {
        didSet {
            delegate?.didGetWeather(String(temperature))
        }
    }
    private var recommendations: String = "" {
        didSet {
            delegate?.didGetRecommendations(recommendations)
        }
    }
    private var location: CLLocation? {
        didSet {
            let latitude = location!.coordinate.latitude
            let longitude = location!.coordinate.longitude
            
            getTemperature(latitude: latitude, longitude: longitude)
        }
    }
    private let userLocationManager = UserLocationManager()
    
    // MARK: - Initializer
    
    init(delegate: RecommendationViewDelegate) {
        self.delegate = delegate
        setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        userLocationManager.delegate = self
        getLocation()
    }
    
    private func getLocation() {
        userLocationManager.getLocation()
    }
    
    private func getTemperature(latitude: Double, longitude: Double) {
        WeatherNetworking.getWeatherFor(latitude: latitude, longitude: longitude) { weatherData in
            self.temperature = weatherData.currently.temperature
            self.setRecommendations(for: self.temperature)
        }
    }

    private func generateRecommendation(for temp: Double, from items: [ClothingItem]) -> [ClothingItem] {
        return items.filter { $0.tempRange.contains(temp) }
    }

    private func setRecommendations(for temperature: Double) {
        let recommendedItems = generateRecommendation(for: temperature, from: allClothingItems)
        let outfit = Outfit(components: recommendedItems)
        recommendations = outfit.recommendations
    }

}

extension RecommendationViewModel: UserLocationManagerDelegate {
    func didFail(errorDescription: String) {
        delegate?.didFailToGetWeather(errorDescription)
    }
    
    
    func didGetLocation() {
        location = userLocationManager.location
    }
    
}
