//
//  RecommendationViewModel.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

struct RecommendationViewModel {
    
    func generateRecommendation(for temp: Int) -> [ClothingItem] {
        var recommendedItems: [ClothingItem] = []
        for item in allClothingItems {
            if item.tempRange.contains(temp) {
                recommendedItems.append(item)
            }
        }
        return recommendedItems
    }
    
}
