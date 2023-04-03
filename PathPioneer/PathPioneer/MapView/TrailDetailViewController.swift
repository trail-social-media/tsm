//
//  TrailDetailViewController.swift
//  PathPioneer
//
//  Created by Dev Patel on 4/2/23.
//

import UIKit
import MapKit

class TrailDetailViewController: UIViewController {

    @IBOutlet weak var trailMap: MKMapView!
    @IBOutlet weak var trailName: UILabel!
    @IBOutlet weak var trailDesc: UILabel!
    
    var trail: Trail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        trailName.text = trail.trailName
        trailDesc.text = trail.trailDesc
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
