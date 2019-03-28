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
//            self.delegate?.didGetWeather() Could move into didSet
        }
    }
    
    // Is there a reason the temp param is an int instead of a double?
    func generateRecommendation(for temp: Int, from items: [ClothingItem]) -> [ClothingItem] {
        return items.filter{ $0.tempRange.contains(temp) }
    }
    
    func getRecommendation() {
        guard let temp = temperature else { // could remove self. from temperature
            print("no temp")
            return
        }
        let tempInt = Int(temp) // if the param is changed to int wont need to cast
        let recommendedItems = generateRecommendation(for: tempInt, from: allClothingItems)
        let outfit = Outfit(components: recommendedItems)
        recommendation = outfitString(from: outfit) // could remove self. from self.recommentation
//        self.delegate?.didGetRecommendation() Could move into didSet
    }
    
}
