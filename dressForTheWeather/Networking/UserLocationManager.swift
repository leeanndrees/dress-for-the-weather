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
    func didFail(errorDescription: String)
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
    
    func getLocation() {
        locationManager.requestLocation()
    }
    
    func getLocationFrom(address: String, completion: @escaping (CLLocation) -> Void) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
                let location = placemarks.first?.location else {
                    return
            }
            
            completion(location)
        }
    }
    
    func stopLocating() {
        locationManager.stopUpdatingLocation()
    }
    
}

extension UserLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFail(errorDescription: error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        location = newLocation
        delegate?.didGetLocation()
    }

}
