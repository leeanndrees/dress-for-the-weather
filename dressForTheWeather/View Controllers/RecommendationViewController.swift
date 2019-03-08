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
    var temp: Int?
    
    // MARK: - IBOutlets
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var recLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        WeatherNetworking().getWeather()
        setTemp()
        updateTempLabel()
        let rec = viewModel.generateRecommendation(for: temp!, from: allClothingItems)
        let outfit = Outfit(components: rec)
        updateRecLabel(with: outfitString(from: outfit))
    }
    
    func setTemp() {
        temp = 70
    }
    
    func updateTempLabel() {
        guard let temperature = temp else { return }
        tempLabel.text = "\(temperature)°"
    }
    
    func updateRecLabel(with text: String) {
        recLabel.text = text
    }

}

