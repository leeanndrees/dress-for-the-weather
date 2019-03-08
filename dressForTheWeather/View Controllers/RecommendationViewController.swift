//
//  RecommendationViewController.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 2/14/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import UIKit

class RecommendationViewController: UIViewController {
    // MARK: - Properties
    private var viewModel = RecommendationViewModel()
    
    // MARK: - IBOutlets
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var recLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        WeatherNetworking().getWeather()
        let rec = viewModel.generateRecommendation(for: 20, from: allClothingItems)
        let outfit = Outfit(components: rec)
        print(outfitString(from: outfit))
    }

}

