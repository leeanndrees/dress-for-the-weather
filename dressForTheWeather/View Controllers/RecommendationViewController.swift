//
//  RecommendationViewController.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 2/14/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import UIKit

class RecommendationViewController: UIViewController {
//    private var viewModel: RecommendationViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherNetworking().getWeather()

    }


}

