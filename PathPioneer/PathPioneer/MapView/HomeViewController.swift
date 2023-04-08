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
    var oldLocation: CLLocation! = nil
    var isNewTrail: Bool! = false
    var trail: Trail! = nil

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isEnabled = false
        stopButton.tintColor = UIColor.red
        startButton.tintColor = UIColor.green
        createButton.tintColor = UIColor.orange
        restartButton.isEnabled = false
        createButton.isEnabled = false
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 3.0
        locationManager.delegate = self;

        // user activated automatic authorization info mode
        var status = locationManager.authorizationStatus
        
        switch (status) {
        case .authorizedAlways, .authorizedWhenInUse:
            break;
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            print("Location Servies: Denied / Restricted")
            presentGoToSettingsAlert()
        }
        
        status = locationManager.authorizationStatus
        if ((status == .authorizedAlways) || (status == .authorizedWhenInUse)) {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
            mapView.showsUserLocation = true
            //mapview setup to show user location
            mapView.delegate = self
            mapView.mapType = MKMapType(rawValue: 0)!
            //mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
            mapView.userTrackingMode = .follow
        }
        
        // Do any additional setup after loading the view.
        
        //mapView.delegate = self
        //mapView.userTrackingMode = .follow
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (isNewTrail) {
            
        }
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        
        
        startButton.isEnabled = false
        restartButton.isEnabled = true
        stopButton.isEnabled = true
        createButton.isEnabled = false
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        if (trail == nil) {
            let alertController = UIAlertController(title: "Restart current trail? Unsaved trail data will be removed.", message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let restartAction = UIAlertAction(title: "Restart", style: .destructive) {_ in
                self.restartTrail()
            }
            
            alertController.addAction(restartAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true)
        }
    }
    
    func restartTrail() {
        trail = nil
        
        // Reset map here
        
        startButton.isEnabled = true
        stopButton.isEnabled = false
        restartButton.isEnabled = false;
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        stopButton.isEnabled = false
        createButton.isEnabled = true
    }
    
    func presentGoToSettingsAlert() {
        let alertController = UIAlertController (
            title: "Location Access Required",
            message: "In order to use the features of this app, location services need to be enabled. You can enable them in settings",
            preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }

        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createTrailViewController = segue.destination as? CreateTrailViewController {
            createTrailViewController.trail = trail
        }
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        /*
        if let location = locations.first {
            print("present location : \(location.coordinate.latitude), \(location.coordinate.longitude)")
        }
         */
        if oldLocation == nil {
            oldLocation = locations.first as CLLocation?
            return
        }
        
        if let newLocation = locations.first as CLLocation?,
           newLocation.coordinate.latitude != oldLocation.coordinate.latitude,
           newLocation.coordinate.longitude != oldLocation.coordinate.longitude {
            let oldCoordinates = oldLocation.coordinate
            let newCoordinates = newLocation.coordinate
            var area = [oldCoordinates, newCoordinates]
            var polyline = MKPolyline(coordinates: &area, count: area.count)
            self.mapView.addOverlay(polyline)
            print("Polyline added for old coord: [\(oldLocation.coordinate.latitude),  \(oldLocation.coordinate.longitude)] to new coord: [\(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)]")
            oldLocation = newLocation
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
    /*
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        if let oldLocationNew = oldLocation as CLLocation? {
             let oldCoordinates = oldLocationNew.coordinate
             let newCoordinates = newLocation.coordinate
             var area = [oldCoordinates, newCoordinates]
             var polyline = MKPolyline(coordinates: &area, count: area.count)
             self.mapView.addOverlay(polyline)
        }
    }
     */
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView!, rendererFor overlay: MKOverlay!) -> MKOverlayRenderer! {
        let pr = MKPolylineRenderer(overlay: overlay)
        pr.strokeColor = UIColor.red
        pr.lineWidth = 5
        return pr

    }
}
