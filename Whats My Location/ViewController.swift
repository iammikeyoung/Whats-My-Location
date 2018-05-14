//
//  ViewController.swift
//  Whats My Location
//
//  Created by Michael Young on 5/14/18.
//  Copyright © 2018 Michael Young. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        self.latitudeLabel.text = String(location.coordinate.latitude)
        self.longitudeLabel.text = String(location.coordinate.longitude)
        self.directionLabel.text = String(location.course)
        self.speedLabel.text = String(location.speed)
        self.altitudeLabel.text = String(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print(error)
            } else {
                if let placemark = placemarks?[0] {
                    var address = ""
                    if placemark.subThoroughfare != nil {
                        address += placemark.subThoroughfare! + " "
                    }
                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare! + "\n"
                    }
                    if placemark.locality != nil {
                        address += placemark.locality! + ","
                    }
                    if placemark.administrativeArea != nil {
                        address += placemark.administrativeArea! + " "
                    }
                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + "\n"
                    }
                    if placemark.country != nil {
                        address += placemark.country!
                    }
                    self.addressLabel.text = address
                }
            }
        }
        
    }

}

