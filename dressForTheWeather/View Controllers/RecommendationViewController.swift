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
    private lazy var backgroundGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        return gradientLayer
    }()

    // MARK: - IBOutlets

    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var recommendationLabel: UILabel!
    @IBOutlet var clothingCollectionView: ClothingCollectionView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = RecommendationViewModel(delegate: self)
        addBackgroundGradientLayer()
    }

    // MARK: - Methods

    private func updateTempLabel(with temperature: String) {
        temperatureLabel.text = "\(temperature)"
    }

    private func updateRecommendationLabel(with recommendations: String) {
        recommendationLabel.text = "\(recommendations)"
    }
    
    private func updateBackgroundGradientLayer() {
        backgroundGradientLayer.removeFromSuperlayer()
        backgroundGradientLayer.colors = viewModel.gradientColors
        addBackgroundGradientLayer()
    }

    private func addBackgroundGradientLayer() {
        view.layer.insertSublayer(backgroundGradientLayer, at: 0)
    }

}

//// MARK: - Delegate Methods

extension RecommendationViewController: RecommendationViewDelegate {
    func didFailToGetWeather(_ description: String) {
        let alertController = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(cancelAction)
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
            self.updateBackgroundGradientLayer()
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
