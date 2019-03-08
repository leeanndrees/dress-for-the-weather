//
//  RecommendationViewModel.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

struct RecommendationViewModel {
    
    func generateRecommendation(for temp: Int, from items: [ClothingItem]) -> [ClothingItem] {
        return items.filter{ $0.tempRange.contains(temp) }
    }
    
}
