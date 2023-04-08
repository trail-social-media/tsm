//
//  CreateTrailViewController.swift
//  PathPioneer
//
//  Created by Dev Patel on 4/2/23.
//

import UIKit
import ParseSwift
import PhotosUI

class CreateTrailViewController: UIViewController {

    var trail: Trail!
    var pickedImage: UIImage?
    
    @IBOutlet weak var trailImageView: UIImageView!
    @IBOutlet weak var trailNameField: UITextField!
    @IBOutlet weak var trailDescField: UITextField!
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let trailName = trailNameField.text,
           let trailDesc = trailDescField.text,
              !trailName.isEmpty,
              !trailDesc.isEmpty,
              pickedImage != nil else {
            showMissingFieldsAlert()
            return
        }
        
        trail.trailName = trailName
        trail.trailDesc = trailDesc
        
        view.endEditing(true)

        // TODO: Pt 1 - Create and save Post
        // Unwrap optional pickedImage
        guard let image = pickedImage,
              // Create and compress image data (jpeg) from UIImage
              let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }

        // Creatae a Parse File by providing a name and passing in the image data
        let imageFile = ParseFile(name: "image.jpg", data: imageData)

        // Create Trail object
        var newTrail = Trail(trailName: trail.trailName, trailDesc: trail.trailDesc, latitudes: trail.latitudes, longitudes: trail.longitudes)
        
        // Set properties
        newTrail.imageFile = imageFile

        // Set the user as the current user
        newTrail.user = User.current

        // Save object in background (async)
        newTrail.save { [weak self] result in

            // Switch to the main thread for any UI updates
            DispatchQueue.main.async {
                switch result {
                case .success(let trail):
                    print("✅ Post Saved! \(trail)")
                    
                    DispatchQueue.main.async {
                        // Return to previous view controller
                        self?.navigationController?.popViewController(animated: true)
                    }

                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }
           
    }
    
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Oops...", message: "We need the title and description field filled out to create this trail", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func takePhotoTapped(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("❌📷 Camera not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)

    }
    @IBAction func selectPhotosTapped(_ sender: Any) {
        var config = PHPickerConfiguration()
        
        config.filter = .images
        
        config.preferredAssetRepresentationMode = .current
        
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        
        picker.delegate = self
        
        present(picker, animated:  true)
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

extension CreateTrailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let provider = results.first?.itemProvider,
              provider.canLoadObject(ofClass: UIImage.self) else {
            return
        }

        provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
            guard let image = object as? UIImage else {
                self?.showAlert()
                return
            }
            
            if let error = error {
                self?.showAlert(description: error.localizedDescription)
                return
            } else {
                DispatchQueue.main.async {
                    self?.trailImageView.image = image
                    
                    self?.pickedImage = image
                }
            }
        }

    }
}

extension CreateTrailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("❌📷 Unable to get image")
                    return
        }
        
        trailImageView.image = image
        pickedImage = image
    }
}
