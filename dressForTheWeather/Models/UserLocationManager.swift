//
//  UserLocationManager.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/28/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import CoreLocation
import Foundation

class UserLocationManager {
    public var shared: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        return locationManager
    }()
    
    public var sharedLocation: CLLocation?
}
