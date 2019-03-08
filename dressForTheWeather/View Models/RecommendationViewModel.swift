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
        return allClothingItems.filter{ $0.tempRange.contains(temp) }
    }
    
}
