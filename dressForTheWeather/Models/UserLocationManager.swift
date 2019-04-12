//
//  UserLocationManager.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/28/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import CoreLocation
import Foundation

class UserLocationManager: NSObject {
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        return locationManager
    }()
    
    public func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    public func requestLocation() {
        locationManager.requestLocation()
    }
    
}

extension UserLocationManager: CLLocationManagerDelegate {
    //locationManager.requestAlwaysAuthorization()
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error)")
    }
    
    // TO DO: break this out into its own object
    // in the view model, get lat + long from Location Manager
    // pass coordinates to weather API call
    // call weather API call when the location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        var location: CLLocation?
        let newLocation = locations.last!
        location = newLocation
        
        print("new location: \(newLocation)")
        //        updateLabels()
        //        setIcon()
    }

}
