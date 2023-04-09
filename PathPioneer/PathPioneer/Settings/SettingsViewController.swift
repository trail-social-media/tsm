//
//  SettingsViewController.swift
//  PathPioneer
//
//  Created by Dev Patel on 3/25/23.
//

import UIKit
import ParseSwift

class SettingsViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Logout of \(User.current?.username ?? "current account")?", message: nil, preferredStyle: .alert)
        
        let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = User.current?.username

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
