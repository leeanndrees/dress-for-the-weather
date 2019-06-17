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

    private func selectClothingItems(for lowTemp: Double, highTemp: Double, from items: [ClothingItem]) -> [ClothingItem] {
        return items.filter { $0.tempRange.contains(lowTemp) || $0.tempRange.contains(highTemp) }
    }

    private func setRecommendations(for lowTemp: Double, highTemp: Double) {
        let recommendedItems = selectClothingItems(for: lowTemp, highTemp: highTemp, from: allClothingItems)

        recommendedClothingItems = []

        BodyPlacement.allCases.forEach { currentPlacement in
            let itemsWithPlacement = recommendedItems.filter { $0.placement.contains(currentPlacement) }

            guard let randomItem = itemsWithPlacement.randomElement(),
                recommendedClothingItems.filter({ $0.placement.contains(currentPlacement) }).isEmpty else { return }

            recommendedClothingItems.append(randomItem)
        }

        let outfit = Outfit(components: recommendedClothingItems)
        recommendations = outfit.recommendationString
    }

    public func updateBackgroundColors() -> [CGColor]? {
        let colorRanges = getColorTemperatureRanges(from: highTemp)

        print(colorRanges.range1.rawValue, colorRanges.range2.rawValue)
        
        guard let color1 = UIColor(named: colorRanges.range1.rawValue),
            let color2 = UIColor(named: colorRanges.range2.rawValue) else { return nil }

        let colors = [color1.cgColor, color2.cgColor]

        return colors
//        guard let gradientLayer = backgroundGradientLayer else { return }

//        gradientLayer.colors = colors
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 1.5)
//        return gradientLayer
    }

    func getColorTemperatureRanges(from temp: Double) -> (range1: TemperatureRanges, range2: TemperatureRanges) {
        var range1: TemperatureRanges { switch temp {
            case -20...15: return .veryCold
            case 16...35: return .cold
            case 36...50: return .sortaCold
            case 51...67: return .mild
            case 68...77: return .warm
            case 78...110: return .hot
            default: return .mild
            }
        }
        
        let range2 = range1.nextTemp
        return (range1, range2)
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
