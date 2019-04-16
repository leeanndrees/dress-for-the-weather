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
    func didGetWeather()
    func didGetRecommendation()
}

final class RecommendationViewModel {

    // MARK: - Properties

    weak var delegate: RecommendationViewDelegate?
    var temperature: Double?
    var recommendation: String?
    var location: CLLocation?
    private let locationManager = UserLocationManager()

    // MARK: - Initializer

    init(delegate: RecommendationViewDelegate) {
        self.delegate = delegate
        locationManager.delegate = self
    }

    // MARK: - Methods

    func locate() {
        locationManager.requestLocation()
    }

    func setLocation() {
        location = locationManager.location
    }

    func getTemperature(lat: Double, long: Double) {
        WeatherNetworking.getWeather(lat: lat, long: long) { data in
            self.temperature = data.currently.temperature
        }
    }

    func generateRecommendation(for temp: Double, from items: [ClothingItem]) -> [ClothingItem] {
        return items.filter{ $0.tempRange.contains(temp) }
    }

    func getRecommendation() {
        guard let temp = temperature else {
            print("no temp")
            return
        }
        let recommendedItems = generateRecommendation(for: temp, from: allClothingItems)
        let outfit = Outfit(components: recommendedItems)
        recommendation = outfitString(from: outfit)
    }
    
    private func outfitString(from outfit: Outfit) -> String {
        var componentNames: [String] = []
        for component in outfit.components {
            componentNames.append(component.name)
        }
        return componentNames.joined(separator: ", ")
    }

}

extension RecommendationViewModel: UserLocationManagerDelegate {
    func didGetLocation() {
        setLocation()
        
        guard let lat = location?.coordinate.latitude,
            let long = location?.coordinate.longitude else { print("🤔 no location"); return }
        getTemperature(lat: lat, long: long)
    }
}
