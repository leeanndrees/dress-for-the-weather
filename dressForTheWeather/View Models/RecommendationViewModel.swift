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
        super.init()
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
            self.delegate?.didGetWeather()
        }
    }
    
    func generateRecommendation(for temp: Int, from items: [ClothingItem]) -> [ClothingItem] {
        return items.filter{ $0.tempRange.contains(temp) }
    }
    
    func getRecommendation() {
        guard let temp = self.temperature else { print ("no temp"); return }
        let tempInt = Int(temp)
        let recommendedItems = generateRecommendation(for: tempInt, from: allClothingItems)
        let outfit = Outfit(components: recommendedItems)
        self.recommendation = outfitString(from: outfit)
        self.delegate?.didGetRecommendation()
    }
    
}

extension RecommendationViewModel: UserLocationManagerDelegate {
    func didGetLocation() {
        setLocation()
        guard let lat = location?.coordinate.latitude, let long = location?.coordinate.longitude else { print("🤔 no location"); return }
        getTemperature(lat: lat, long: long)
    }
}
