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

class RecommendationViewModel: NSObject {

    // MARK: - Properties

    weak var delegate: RecommendationViewDelegate?
    var temperature: Double?
    var recommendation: String?
    var location: CLLocation?
    let locationManager = UserLocationManager()

    // MARK: - Initializer

    init(delegate: RecommendationViewDelegate) {
        self.delegate = delegate
        super.init() // is this right/ok? I had to do it to be able to set the delegate below
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

}

extension RecommendationViewModel: UserLocationManagerDelegate {
    func didGetLocation() {
        setLocation()
        guard let lat = location?.coordinate.latitude, let long = location?.coordinate.longitude else { print("🤔 no location"); return }
        getTemperature(lat: lat, long: long)
    }
}
