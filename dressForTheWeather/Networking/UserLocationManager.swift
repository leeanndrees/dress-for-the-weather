//
//  UserLocationManager.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 3/28/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import CoreLocation
import Foundation

protocol UserLocationManagerDelegate: AnyObject {
    func didGetLocation()
}

class UserLocationManager: NSObject {
    
    public var location: CLLocation?
    weak var delegate: UserLocationManagerDelegate?
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        return locationManager
    }()
    
    public func getLocation() {
        locationManager.requestLocation()
    }
    
}

extension UserLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        location = newLocation
        delegate?.didGetLocation()
    }

}
