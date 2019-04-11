//
//  UserLocationManager.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/28/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import CoreLocation
import Foundation

class UserLocationManager: CLLocationManager, CLLocationManagerDelegate {

    static let shared = UserLocationManager()
    
    var locations = [CLLocation]()
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        for location in locations {
//            self.locations.append(location)
//        }
//    }
}
