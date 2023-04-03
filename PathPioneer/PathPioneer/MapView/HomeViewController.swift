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

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
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
            locationManager.startUpdatingHeading()
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
