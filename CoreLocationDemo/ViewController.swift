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
                self.showAlert(with: "This is where you are!", and: city)
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
    
    
    // MARK: - Helper functions
    private func showAlert(with message: String, and title: String) {
        // create alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let viewMap = UIAlertAction(title: "View Map", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "MapKitController", sender: self)
            
        })
        
        alertController.addAction(okAction)
        alertController.addAction(viewMap)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

