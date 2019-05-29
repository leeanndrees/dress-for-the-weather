//
//  TempClothingData.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/7/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

// Winter Clothes
var coat = ClothingItem(name: "winter coat", placement: [.torsoOuter], tempRange: -30...35)
var scarf = ClothingItem(name: "scarf", placement: [.neck], tempRange: -30...35)
var coatWithHood = ClothingItem(name: "hooded coat", placement: [.torso, .head], tempRange: -30...35)
var hat = ClothingItem(name: "hat", placement: [.head], tempRange: -30...45)
var gloves = ClothingItem(name: "gloves", placement: [.hands], tempRange: -30...45)
var longJohns = ClothingItem(name: "long underwear", placement: [.legs], tempRange: -30...25)
var warmBoots = ClothingItem(name: "warm boots", placement: [.feet], tempRange: -30...20)
var woolSocks = ClothingItem(name: "wool socks", placement: [.feet], tempRange: -30...30)
var mittens = ClothingItem(name: "mittens", placement: [.hands], tempRange: -30...30)
var sweater = ClothingItem(name: "sweater", placement: [.torso], tempRange: -30...45)

// Mild Weather Clothes
var lightJacket = ClothingItem(name: "light jacket", placement: [.torsoOuter], tempRange: 55...70)
var lightScarf = ClothingItem(name: "lightweight scarf", placement: [.neck], tempRange: 40...60)
var jeans = ClothingItem(name: "jeans", placement: [.legs], tempRange: -30...75)
var tshirt = ClothingItem(name: "t-shirt", placement: [.torso], tempRange: 45...85)
var dress = ClothingItem(name: "dress", placement: [.torso, .legs], tempRange: 40...75)

// Warm Weather Clothes
var shorts = ClothingItem(name: "shorts", placement: [.legs], tempRange: 77...97)
var tank = ClothingItem(name: "tank top", placement: [.torso], tempRange: 77...97)
var sandals = ClothingItem(name: "sandals", placement: [.feet], tempRange: 70...100)
var skirt = ClothingItem(name: "skirt", placement: [.legs], tempRange: 65...100)


var allClothingItems = [
    coat,
    scarf,
    coatWithHood,
    hat,
    gloves,
    longJohns,
    warmBoots,
    woolSocks,
    mittens,
    sweater,
    lightJacket,
    lightScarf,
    jeans,
    tshirt,
    dress,
    shorts,
    tank,
    sandals,
    skirt
]
