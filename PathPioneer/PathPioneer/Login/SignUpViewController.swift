//
//  SignUpViewController.swift
//  PathPioneer
//
//  Created by Dev Patel on 3/25/23.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signUpButtonTapped(_ sender: Any) {
        /*
        guard let username = usernameField.text,
              let password = passwordField.text,
              let email = emailField.text,
              !email.isEmpty,
              !username.isEmpty,
              !password.isEmpty else {
            showMissingFieldsAlert()
            return
        }
        
        // Create a new user and sign up account
        var newUser = User()
        newUser.username = username
        newUser.email = email
        newUser.password = password
        
        newUser.signup{ [weak self] result in
            switch result {
            case .success(let user):
                print("✅ Successfully signed up user \(user)")
                
                // Send notification to access the FeedVC
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
        */
        
        NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
    }
    
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to sign you up.", preferredStyle: .alert)
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
