//
//  TrailCell.swift
//  PathPioneer
//
//  Created by Dev Patel on 4/2/23.
//

import UIKit
import Alamofire
import AlamofireImage

class TrailCell: UITableViewCell {

    var imageDataRequest: DataRequest?
    
    @IBOutlet weak var trailImageView: UIImageView!
    @IBOutlet weak var trailName: UILabel!
    @IBOutlet weak var trailDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure (with trail: Trail) {
        
        // Load UIImage from server imageFile
        if let imageFile = trail.imageFile,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage to help fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.trailImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }
        
        trailName.text = trail.trailName
        trailDesc.text = trail.trailDesc
    }
    
    // Cancel Image load if cell goes out of view
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset image view
        trailImageView.image = nil
        
        // Cancel image request
        imageDataRequest?.cancel()
    }

}
