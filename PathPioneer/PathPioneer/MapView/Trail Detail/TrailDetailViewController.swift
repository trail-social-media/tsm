//
//  TrailDetailViewController.swift
//  PathPioneer
//
//  Created by Dev Patel on 4/2/23.
//

import UIKit
import MapKit
import Alamofire
import AlamofireImage

class TrailDetailViewController: UIViewController {

    @IBOutlet weak var trailMap: MKMapView!
    @IBOutlet weak var trailName: UILabel!
    @IBOutlet weak var trailDesc: UILabel!
    
    var trail: Trail!
    var trailImage: UIImageView!
    var imageDataRequest: DataRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        trailName.text = trail.trailName
        trailDesc.text = trail.trailDesc
        
        trailMap.delegate = self
        
        // Create route on map
        for i in 1...(trail.latitudes!.count - 1) {
            let oldCoordinates = CLLocationCoordinate2D(latitude: trail.latitudes![i - 1], longitude: trail.longitudes![i - 1])
            let newCoordinates = CLLocationCoordinate2D(latitude: trail.latitudes![i], longitude: trail.longitudes![i])
            var area = [oldCoordinates, newCoordinates]
            
            var polyline = MKPolyline(coordinates: &area, count: area.count)
            self.trailMap.addOverlay(polyline)
        }
        
        // Zoom map in
        let centerCoord = CLLocationCoordinate2D(latitude: trail.latitudes![trail.latitudes!.count / 2], longitude: trail.longitudes![trail.longitudes!.count / 2])
        let region = MKCoordinateRegion(center: centerCoord, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        trailMap.setRegion(region, animated: true)
        
        // Create start and end annotations
        let startAnnotation = MKPointAnnotation()
                startAnnotation.coordinate = CLLocationCoordinate2D(latitude: trail.latitudes!.first!, longitude: trail.longitudes!.first!)
                startAnnotation.title = "Start"
                self.trailMap.addAnnotation(startAnnotation)
        let endAnnotation = MKPointAnnotation()
        endAnnotation.coordinate = CLLocationCoordinate2D(latitude: trail.latitudes!.last!, longitude: trail.longitudes!.last!)
                endAnnotation.title = "End"
                self.trailMap.addAnnotation(endAnnotation)
        
        /*
        // Create trail image annotation view
        trailMap.register(TrailAnnotationView.self, forAnnotationViewWithReuseIdentifier: TrailAnnotationView.identifier)
        let annotation = MKPointAnnotation()
        annotation.coordinate = centerCoord
        trailMap.addAnnotation(annotation)
        */
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

extension TrailDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let pr = MKPolylineRenderer(overlay: overlay)
        pr.strokeColor = UIColor.orange
        pr.lineWidth = 5
        return pr
    }
    
    /*
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: TrailAnnotationView.identifier, for: annotation) as? TrailAnnotationView else {
            fatalError("Unable to dequeue Task Annotation View")
        }
        
        // Load UIImage from server imageFile
        if let imageFile = trail.imageFile,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage to help fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    annotationView.configure(with: image)
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }
        return annotationView
    }
    */
}
