//
//  TrailCell.swift
//  PathPioneer
//
//  Created by Dev Patel on 4/2/23.
//

import UIKit

class TrailCell: UITableViewCell {

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
        trailName.text = trail.trailName
        trailDesc.text = trail.trailDesc
    }

}
