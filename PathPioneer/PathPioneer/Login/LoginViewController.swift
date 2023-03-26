//
//  LoginViewController.swift
//  PathPioneer
//
//  Created by Dev Patel on 3/25/23.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        // For now, just pressing login will allow user to login
        
        NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
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
