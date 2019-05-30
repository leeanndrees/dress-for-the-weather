//
//  RecommendationViewModel.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

// MARK: - Delegate Protocol

protocol RecommendationViewDelegate: AnyObject {
    func didGetWeather(_ weather: String)
    func didGetRecommendations(_ recommendations: String)
    func didFailToGetWeather(_ description: String)
}

final class RecommendationViewModel {
    
    // MARK: - Properties
    
    weak var delegate: RecommendationViewDelegate?
    private var lowTemp: Double = 0
    private var highTemp: Double = 0
    public var recommendedClothingItems: [ClothingItem] = []
    private var temperature: Double = 0 {
        didSet {
            delegate?.didGetWeather(String("\(Int(lowTemp.rounded()))º / \(Int(highTemp.rounded()))º"))
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
    public var backgroundGradientLayer: CAGradientLayer? {
        guard let mildGreenColor = UIColor(named: "mildGreen"),
            let warmOrangeColor = UIColor(named: "warmOrange") else { return nil }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [mildGreenColor.cgColor, warmOrangeColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1.5)
        return gradientLayer
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
        WeatherNetworking.getWeatherFor(latitude: latitude, longitude: longitude, success: { weatherData in
            self.lowTemp = weatherData.daily.data[0].temperatureLow
            self.highTemp = weatherData.daily.data[0].temperatureHigh
            self.setRecommendations(for: self.lowTemp, highTemp: self.highTemp)
            self.temperature = weatherData.currently.temperature
        }, failure: { error in
            self.delegate?.didFailToGetWeather(error.localizedDescription)
        }
        )
    }
    
    private func generateRecommendation(for lowTemp: Double, highTemp: Double, from items: [ClothingItem]) -> [ClothingItem] {
        return items.filter { $0.tempRange.contains(lowTemp) || $0.tempRange.contains(highTemp) }
    }
    
    private func setRecommendations(for lowTemp: Double, highTemp: Double) {
        let recommendedItems = generateRecommendation(for: lowTemp, highTemp: highTemp, from: allClothingItems)
        
        recommendedClothingItems = []
        
        BodyPlacement.allCases.forEach { currentPlacement in
            let itemsWithPlacement = recommendedItems.filter { $0.placement.contains(currentPlacement) }
            
            guard let randomItem = itemsWithPlacement.randomElement(),
                recommendedClothingItems.filter({ $0.placement.contains(currentPlacement) }).isEmpty else { return }
            
            recommendedClothingItems.append(randomItem)
        }
      
        let outfit = Outfit(components: recommendedClothingItems)
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
