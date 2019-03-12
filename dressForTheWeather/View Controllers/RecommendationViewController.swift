//
//  RecommendationViewController.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 2/14/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import UIKit

final class RecommendationViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: RecommendationViewModel!
    
    // MARK: - IBOutlets
    
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var recommendationLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RecommendationViewModel(delegate: self)
        viewModel.getWeather()
    }
    
    // MARK: - Methods
    
    private func updateTempLabel() {
        if let temperature = viewModel.temperature {
            tempLabel.text = "Temperature: \(temperature)"
        } else {
            tempLabel.text = "Temperature is Not Currently Available"
        }
    }
    
    private func updateRecommendationLabel() {
        recommendationLabel.text = "Recommended outfit: \(viewModel.recommendations)"
    }

}

extension RecommendationViewController: RecommendationViewDelegate {
    
    func didGetRecommendations() {
        DispatchQueue.main.async {
            self.updateRecommendationLabel()
        }
    }
    
    func didGetWeather() {
        DispatchQueue.main.async {
            self.updateTempLabel()
        }
    }
    
}
