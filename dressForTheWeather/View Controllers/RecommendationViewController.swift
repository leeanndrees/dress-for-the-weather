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
    @IBOutlet var locationButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = RecommendationViewModel(delegate: self)
        setupGradient()
        addBackgroundGradientLayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        backgroundGradientLayer.removeFromSuperlayer()
        backgroundGradientLayer.colors = viewModel.gradientColors
    }

    private func addBackgroundGradientLayer() {
        view.layer.insertSublayer(backgroundGradientLayer, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "LocationTableViewController",
            let locationTableViewController = segue.destination as? LocationTableViewController else { return }
            
        locationTableViewController.completion = { location in
            DispatchQueue.main.async {
                self.viewModel.getLocation(from: location)
            }
        }
    }

}

// MARK: - Delegate Methods

extension RecommendationViewController: RecommendationViewDelegate {
    func didGetLocation(_ city: String) {
        locationButton.setTitle(city, for: .normal)
    }
    
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
            self.addBackgroundGradientLayer()
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
