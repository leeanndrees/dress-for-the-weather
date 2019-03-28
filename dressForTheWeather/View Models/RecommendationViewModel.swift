//
//  RecommendationViewModel.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

// MARK: - Delegate Protocol
protocol RecommendationViewDelegate: AnyObject {
    func didGetWeather()
    func didGetRecommendation()
}

class RecommendationViewModel {
    
    // MARK: - Properties
    
    weak var delegate: RecommendationViewDelegate?
    var temperature: Double? {
        didSet {
            delegate?.didGetWeather()
            getRecommendation()
        }
    }
    var recommendation: String? {
        didSet {
            delegate?.didGetRecommendation()
        }
    }
    
    // MARK: - Initializer
    
    init(delegate: RecommendationViewDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Methods
    
    func getTemperature() {
        WeatherNetworking.getWeather { data in
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
