//
//  ClothingCollectionVIew.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 5/23/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation
import UIKit

final class ClothingCollectionView: UICollectionView {
    
    // MARK: - Properties
    private let reuseIdentifier = "ClothingCell"
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    let things = ["thing", "other thing", "hat", "pants", "shirt"]
}

//extension ClothingCollectionView: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return things.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//        cell.backgroundColor = .red
//        
//        return cell
//    }
//    
//    
//}
