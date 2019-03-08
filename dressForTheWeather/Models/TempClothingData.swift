//
//  TempClothingData.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

let clothingItems: [ClothingItem] = []

var coat = ClothingItem(name: "winter coat", placement: [.torso], tempRange: -30...35)
var scarf = ClothingItem(name: "scarf", placement: [.neck], tempRange: -30...35)
var coatWithHood = ClothingItem(name: "hooded coat", placement: [.torso, .head], tempRange: -30...35)

let outfit1 = Outfit(components: [coat, scarf])
