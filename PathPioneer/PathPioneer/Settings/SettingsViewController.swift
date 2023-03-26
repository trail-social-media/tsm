//
//  SettingsViewController.swift
//  PathPioneer
//
//  Created by Dev Patel on 3/25/23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBAction func logoutButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
