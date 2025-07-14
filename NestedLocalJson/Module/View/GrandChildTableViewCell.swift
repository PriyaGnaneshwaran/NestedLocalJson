//
//  GrandChildTableViewCell.swift
//  NestedLocalJson
//
//  Created by Priya Gnaneshwaran on 02/07/25.
//

import UIKit

class GrandChildTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    let selectedImage   = UIImage(systemName:"checkmark.circle.fill")
    let unselectedImage = UIImage(systemName: "checkmark.circle")
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ item: PreferenceItem) {
        lblTitle.text = item.title
        let imageName = item.isExpanded ? selectedImage : unselectedImage
        img.image = imageName
    }
}
