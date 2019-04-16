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
    private let locationManager = UserLocationManager()
    
    // MARK: - Initializer
    
    init(delegate: RecommendationViewDelegate) {
        self.delegate = delegate
        setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        locationManager.delegate = self
        getLocation()
    }
    
    // MARK: - Private Methods
    
    private func getLocation() {
        locationManager.requestLocation()
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
        recommendations = outfitString(from: outfit)
    }
    
    private func outfitString(from outfit: Outfit) -> String {
        let componentNames = outfit.components.map { $0.name }
        return componentNames.joined(separator: ", ")
    }

}

extension RecommendationViewModel: UserLocationManagerDelegate {
    
    func didGetLocation() {
        location = locationManager.location
    }
    
}
