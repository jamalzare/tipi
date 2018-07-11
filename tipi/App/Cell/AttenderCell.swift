//
//  AttenderCell.swift
//  tipi
//
//  Created by Jamal on 7/11/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit

class AttenderCell: UICollectionViewCell {

    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var cityLabel:UILabel!
    
    var attender: Attender? {
        didSet{
            imageView.setImageFromUrl(attender?.avatar)
            nameLabel.text = attender?.name
            cityLabel.text = attender?.city
        }
    }
    
    func design(){
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.height/2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        design()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
