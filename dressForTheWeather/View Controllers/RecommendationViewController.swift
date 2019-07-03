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
    private lazy var backgroundGradientLayer = CAGradientLayer()
    
    // MARK: - IBOutlets

    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var recommendationLabel: UILabel!
    @IBOutlet var clothingCollectionView: ClothingCollectionView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = RecommendationViewModel(delegate: self)
        setupGradient()
        setBackgroundColor()
    }

    // MARK: - Methods

    private func updateTempLabel(with temperature: String) {
        temperatureLabel.text = "\(temperature)"
    }

    private func updateRecommendationLabel(with recommendations: String) {
        recommendationLabel.text = "\(recommendations)"
    }
    
    private func setupGradient() {
        backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.frame = view.bounds
        backgroundGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        backgroundGradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }
    
    private func updateBackgroundColors() {
        self.backgroundGradientLayer.removeFromSuperlayer()
        let colors = self.viewModel.updateBackgroundColors()
        self.backgroundGradientLayer.colors = colors
    }

    private func setBackgroundColor() {
        view.layer.insertSublayer(backgroundGradientLayer, at: 0)
    }

}

// MARK: - Delegate Methods

extension RecommendationViewController: RecommendationViewDelegate {
    func didFailToGetWeather(_ description: String) {
        let alertController = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(cancelAction)
//        TODO: fix this error alert so it only shows when needed:
//        present(alertController, animated: true)
    }


    func didGetRecommendations(_ recommendations: String) {
        DispatchQueue.main.async {
            self.updateRecommendationLabel(with: recommendations)
            self.clothingCollectionView.reloadData()
        }
    }

    func didGetWeather(_ weather: String) {
        DispatchQueue.main.async {
            self.updateTempLabel(with: weather)
            self.updateBackgroundColors()
            self.setBackgroundColor()
        }
    }

}

extension RecommendationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recommendedClothingItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClothingCell", for: indexPath) as! ClothingCollectionViewCell

        cell.itemLabel.text = viewModel.recommendedClothingItems[indexPath.row].name
        cell.itemImage.image = viewModel.recommendedClothingItems[indexPath.row].image

        return cell
    }
}
