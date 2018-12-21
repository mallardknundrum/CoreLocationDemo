//
//  MapKitViewController.swift
//  CoreLocationDemo
//
//  Created by MCS on 12/20/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {
    var initialLocation: CLLocation?
    let regionRadius: CLLocationDistance = 1000
    let annotation = MKPointAnnotation()

    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        LocationManager.shared.getLastLocation  { (optionalPlacemark) in

            let placemark = optionalPlacemark

            // Coordinates
            guard let latitud = placemark?.location?.coordinate.latitude else { return }
            guard let longitud = placemark?.location?.coordinate.longitude else { return }

            // Actual Location
            self.initialLocation = CLLocation(latitude: latitud, longitude: longitud)

            // Setting the Point Location
            self.annotation.coordinate = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
            self.centerMapOnLocation(location: self.initialLocation!)
            self.mapView.addAnnotation(self.annotation)
        }
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
