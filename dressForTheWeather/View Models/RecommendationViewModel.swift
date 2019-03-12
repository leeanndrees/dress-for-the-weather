//
//  RecommendationViewModel.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

protocol RecommendationViewDelegate: AnyObject {
    func didGetWeather()
    func didGetRecommendations()
}

final class RecommendationViewModel {
    
    // MARK: - Properties
    
    weak var delegate: RecommendationViewDelegate?
    var temperature: Double? // get set?
    var recommendations: String = "" // get set?
    
    // MARK: - Initializer
    
    init(delegate: RecommendationViewDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Methods
    
    func getWeather() {
        WeatherNetworking.getWeather { data in
            self.temperature = data.currently.temperature
            self.delegate?.didGetWeather()
            self.createOutfit(from: clothingItems, and: data.currently.temperature)
        }
    }
    
    func createOutfit(from clothingItems: [ClothingItem], and temperature: Double) {
        // TODO: hook up a database call to see what clothing this person has to pull from
        let recommendedClothes = clothingItems.filter { $0.tempRange.contains(temperature) }
        let outfitString = Outfit(components: recommendedClothes).outfitString()
        
        // Will set recommendations property with a call to the database
        recommendations = outfitString
        delegate?.didGetRecommendations()
    }
    
}
