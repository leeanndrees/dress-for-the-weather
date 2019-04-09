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
    var temp: Int?
    private var viewModel: RecommendationViewModel!
    
    // MARK: - IBOutlets
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var recLabel: UILabel!
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RecommendationViewModel(delegate: self)
        viewModel.locate()
    }
    
    // MARK: - Methods
    
    func updateTempLabel() {
        guard let temperature = viewModel.temperature else { return }
        tempLabel.text = String(format: "%.0f", temperature)
    }
    
    func updateRecLabel(with text: String) {
        recLabel.text = text
    }

}

// MARK: - Delegate Methods

extension RecommendationViewController: RecommendationViewDelegate {
    func didGetWeather() {
        DispatchQueue.main.async {
            self.updateTempLabel()
            self.viewModel.getRecommendation()
        }
    }
    
    func didGetRecommendation() {
        DispatchQueue.main.async {
            guard let rec = self.viewModel.recommendation else { return }
            self.updateRecLabel(with: rec)
        }
    }
    
}
