//
//  LoginViewController.swift
//  PathPioneer
//
//  Created by Dev Patel on 3/25/23.
//

import UIKit
import ParseSwift

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginButtonTapped(_ sender: Any) {
        /*
        guard let username = usernameField.text,
              let password = passwordField.text,
              !username.isEmpty,
              !password.isEmpty else {
            showMissingFieldsAlert()
            return
        }
        
        // Login the user
        User.login(username: username, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                print("✅ Successfully logged in as user: \(user)")
                
                // Post a notificaiton that user was logged in, so that the FeedVC is pulled up
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
         */
        
        // For now, just pressing login will allow user to login
        
        NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Oops...", message: "We need the user and password field filled out to log you in", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
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
