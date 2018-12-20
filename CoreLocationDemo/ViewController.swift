//
//  ViewController.swift
//  CoreLocationDemo
//
//  Created by Jeremiah Hawks on 12/20/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBAction func locationButtonPressed(_ sender: Any) {
        LocationManager.shared.getLastLocation { (optionalPlacemark) in
            if let placemark = optionalPlacemark, let city = placemark.locality {
                self.showAlert(with: "This is where you are!", and: city, on: placemark)
            }
        }
        // save in variable to allow easy access to display
        // Display location
    }
    
    // MARK: = Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LocationManager.shared.setUpCLManager()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MapViewController
        destination.placemark = sender as? CLPlacemark
    }
    
    
    // MARK: - Helper functions
    private func showAlert(with message: String, and title: String, on placemark: CLPlacemark) {
        // create alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let mapAction = UIAlertAction(title: "Show on Map", style: .default) { _ in
            self.performSegue(withIdentifier: "mapSegue", sender: placemark)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(mapAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

