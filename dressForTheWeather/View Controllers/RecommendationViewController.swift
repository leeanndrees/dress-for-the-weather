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
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var recommendationLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RecommendationViewModel(delegate: self)
    }
    
    // MARK: - Methods
    
    private func updateTempLabel(with temperature: String) {
        temperatureLabel.text = "Temperature: \(temperature)"
    }
    
    private func updateRecommendationLabel(with recommendations: String) {
        recommendationLabel.text = "Recommended outfit: \(recommendations)"
    }

}

//// MARK: - Delegate Methods

extension RecommendationViewController: RecommendationViewDelegate {
    func didFailToGetWeather(_ description: String) {
        let alertController = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    
    func didGetRecommendations(_ recommendations: String) {
        DispatchQueue.main.async {
            self.updateRecommendationLabel(with: recommendations)
        }
    }
    
    func didGetWeather(_ weather: String) {
        DispatchQueue.main.async {
            self.updateTempLabel(with: weather)
        }
    }
    
}
