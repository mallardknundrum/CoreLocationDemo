//
//  MapViewController.swift
//  CoreLocationDemo
//
//  Created by Frakcool on 12/20/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var placemark: CLPlacemark?
    let regionRadius: CLLocationDistance = 1000
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let secureLocation = location else {
            return
        }
        
        centerMapOnLocation(location: secureLocation)
        addUserAnnotation(location: secureLocation)
    }
    
    func setupMap(placemark: CLPlacemark) {
        self.location = placemark.location
    }
    
    func addUserAnnotation(location: CLLocation) {
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = location.coordinate
        userAnnotation.title = "You are here!"
        
        mapView.addAnnotation(userAnnotation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
    }
}
