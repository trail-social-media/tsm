//
//  HomeViewController.swift
//  PathPioneer
//
//  Created by Dev Patel on 3/25/23.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController {
    
    var locationManager: CLLocationManager!

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;

        // user activated automatic authorization info mode
        let status = locationManager.authorizationStatus
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
        //locationManager.startUpdatingHeading()
        
        // Do any additional setup after loading the view.
        
        //mapView.delegate = self
        mapView.showsUserLocation = true
        //mapView.userTrackingMode = .follow
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("present location : \(location.coordinate.latitude), \(location.coordinate.longitude)")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
                    case .notDetermined:
                        print("Not determined")
                    case .restricted:
                        print("Restricted")
                    case .denied:
                        print("Denied")
                    case .authorizedAlways:
                        print("Authorized Always")
                    case .authorizedWhenInUse:
                        print("Authorized When in Use")
                    @unknown default:
                        print("Unknown status")
                    }
    }
    /*
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    */
    
}
