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
        
        // Update UI
        stopButton.isEnabled = false
        stopButton.tintColor = UIColor.red
        startButton.tintColor = UIColor.green
        createButton.tintColor = UIColor.orange
        restartButton.isEnabled = false
        createButton.isEnabled = false
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.mapType = MKMapType(rawValue: 0)!
        
        // Set up Location Manager
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 3.0
        locationManager.delegate = self;

        // Check location authorization status
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
        
        if (CLLocationManager.locationServicesEnabled()) {
            mapView.setUserTrackingMode(.follow, animated: true)
            trail = Trail()
            trail.longitudes = [Double]()
            trail.latitudes = [Double]()
        } else {
            startButton.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (isNewTrail) {
            restartTrail()
            isNewTrail = false
        }
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        locationManager.startUpdatingLocation()
        startButton.isEnabled = false
        restartButton.isEnabled = true
        stopButton.isEnabled = true
        createButton.isEnabled = false
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Restart current trail? Unsaved trail data will be removed.", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let restartAction = UIAlertAction(title: "Restart", style: .destructive) {_ in
            self.restartTrail()
        }
        
        alertController.addAction(restartAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    func focusMap() {
        
    }
    
    func restartTrail() {
        trail = Trail()
        trail.longitudes = [Double]()
        trail.latitudes = [Double]()
        
        // Reset map here
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.stopUpdatingLocation()
        }
        oldLocation = nil
        
        startButton.isEnabled = true
        stopButton.isEnabled = false
        restartButton.isEnabled = false
        createButton.isEnabled = false
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        stopButton.isEnabled = false
        createButton.isEnabled = true
        let region = MKCoordinateRegion(center: oldLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        mapView.setRegion(region, animated: true)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createTrailViewController = segue.destination as? CreateTrailViewController {
            createTrailViewController.trail = trail
            createTrailViewController.homeViewController = self
        }
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if oldLocation == nil {
            oldLocation = locations.first as CLLocation?
            return
        }
        
        // Update Map UI to follow User
        if (mapView.userTrackingMode == .none) {
            mapView.setUserTrackingMode(.follow, animated: true)
            let region = MKCoordinateRegion(center: oldLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            mapView.setRegion(region, animated: true)
        }
        
        // Use new location data
        if let newLocation = locations.first as CLLocation?,
           newLocation.coordinate.latitude != oldLocation.coordinate.latitude,
           newLocation.coordinate.longitude != oldLocation.coordinate.longitude {
            let oldCoordinates = oldLocation.coordinate
            let newCoordinates = newLocation.coordinate
            var area = [oldCoordinates, newCoordinates]
            
            // Creates route on map
            var polyline = MKPolyline(coordinates: &area, count: area.count)
            self.mapView.addOverlay(polyline)
            print("Polyline added for old coord: [\(oldLocation.coordinate.latitude),  \(oldLocation.coordinate.longitude)] to new coord: [\(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)]")
            
            // Update location values
            oldLocation = newLocation
            trail.latitudes?.append(Double(oldLocation.coordinate.latitude))
            trail.longitudes?.append(Double(oldLocation.coordinate.longitude))
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
        pr.strokeColor = UIColor.orange
        pr.lineWidth = 5
        return pr
    }
}
