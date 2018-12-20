//
//  LocationManager.swift
//  CoreLocationDemo
//
//  Created by Jeremiah Hawks on 12/20/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {

    // singleton
    static let shared = LocationManager()
    
    // location manager
    let clManager = CLLocationManager()
    var locations: [CLLocation] = []
    
    // private init to ensure singleton
    private override init() {
        super.init()
    }
    
    // MARK: - Helper Functions
    
    func setUpCLManager() {
        clManager.delegate = self
        checkLocationPermissions()
        clManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationPermissions() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // request permission
            requestPermissions()
            return
        case .restricted, .denied:
            // possible alert controller to inform
            print("access to location services has either been denied or it is restricted..")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Hooray! its authorized!")
            clManager.startUpdatingLocation()
        }
    }
    
    func requestPermissions() {
        clManager.requestWhenInUseAuthorization()
    }
    
    func getLastLocation(completion: @escaping (CLPlacemark?) -> Void) {
        if locations.count > 0 {
            let location = locations[0]
            CLGeocoder().reverseGeocodeLocation(location) { (optionalPlacemarkArray, optionalError) in
                if let error = optionalError {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                if let placemark = optionalPlacemarkArray?[0] {
                    completion(placemark)
                    return
                }
            }
        } else {
            completion(nil)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locations = locations
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationPermissions()
    }
}
