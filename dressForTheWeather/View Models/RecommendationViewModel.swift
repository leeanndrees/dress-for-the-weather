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
    let locationManager = UserLocationManager.shared
    
    // MARK: - Initializer
    
    init(delegate: RecommendationViewDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Methods
    
    func locate() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestLocation()
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

extension RecommendationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error)")
    }
    
    // TO DO: break this out into its own object
    // in the view model, get lat + long from Location Manager
    // pass coordinates to weather API call
    // call weather API call when the location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location: CLLocation?
        let newLocation = locations.last!
        location = newLocation
        guard let lat = location?.coordinate.latitude, let long = location?.coordinate.longitude else { print("ahh"); return }
        getTemperature(lat: lat, long: long)
    }
}
