//
//  MapViewController.swift
//  CoreLocationDemo
//
//  Created by Isai Yepez on 12/21/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.showsUserLocation = true
        
    }
}
