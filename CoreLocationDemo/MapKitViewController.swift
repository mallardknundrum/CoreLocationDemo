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
    let regionRadius : CLLocationDistance = 1000
    let annotation = MKPointAnnotation()

    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        LocationManager.shared.getLastLocation  { (optionalPlacemark) in

            let placemark = optionalPlacemark

            let getLatitud = placemark?.location?.coordinate.latitude
            let getLongitud = placemark?.location?.coordinate.longitude

            self.initialLocation = CLLocation(latitude: getLatitud!, longitude: getLongitud!)

            self.annotation.coordinate = CLLocationCoordinate2D(latitude: getLatitud!, longitude: getLongitud!)
            self.centerMapOnLocation(location: self.initialLocation!)
            self.mapView.addAnnotation(self.annotation)
        }
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
