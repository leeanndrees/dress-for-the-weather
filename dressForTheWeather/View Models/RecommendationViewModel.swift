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
    var temperature: Double?
    var recommendation: String?
    
    // MARK: - Initializer
    
    init(delegate: RecommendationViewDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Methods
    
    func generateRecommendation(for temp: Int, from items: [ClothingItem]) -> [ClothingItem] {
        return items.filter{ $0.tempRange.contains(temp) }
    }
    
    func getTemperature() {
        WeatherNetworking.getWeather { data in
            self.temperature = data.currently.temperature
            self.delegate?.didGetWeather()
        }
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
