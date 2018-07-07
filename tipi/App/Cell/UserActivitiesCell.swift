//
//  UserActivitiesCell.swift
//  tipi
//
//  Created by Jamal on 7/7/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit


class UserActivitiesCell: UICollectionViewCell {

    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var atLabel:UILabel!
    
    
    var activity: UserActivity? {
        didSet{
            setup()
        }
    }
    
    func design(){
        imageView.layer.cornerRadius = 2
        imageView.layer.masksToBounds = true
        
    }
    
    func setup(){
        imageView.setImageFromUrl(activity?.image)
        titleLabel.text = activity?.title
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
