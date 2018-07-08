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
    @IBOutlet weak var attendsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var attendsContainerView:UIView!
    
    
    var hasAttendeeds = false {
        didSet{
            let constant: CGFloat = hasAttendeeds ? 42:0
            attendsHeightConstraint.constant = constant
            self.layoutIfNeeded()
        }
    }
    
    var activity: UserActivity? {
        didSet{
            setup()
        }
    }
    
    func createAndAddAttenderImage(index: Int){
        let frame =  CGRect(x: CGFloat(index*22+5), y: 0, width: 22, height: 22)
        let iv = UIImageView(frame: frame)
        iv.layer.cornerRadius = iv.frame.width/2
        iv.clipsToBounds = true
        iv.setImageFromUrl(activity?.attendees[index].avatar)
        attendsContainerView.addSubview(iv)
    }
    
    func design(){
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        
        titleLabel.font = UIFont(name: "SFProText-Medium", size: 17)
        titleLabel.sizeToFit()
        
        atLabel.font = UIFont(name: "SFProText-Regular", size: 13)
        atLabel.sizeToFit()
        
    }
    
    func setup(){
        imageView.setImageFromUrl(activity?.image, defaultImage: #imageLiteral(resourceName: "loadingImage.png"))
        titleLabel.text = activity?.title
        atLabel.text = "15 Jul, 12:30"
        hasAttendeeds = activity?.hasAttender ?? false
        let count = activity?.attendees.count ?? 0
        for i in 0..<count{
            createAndAddAttenderImage(index: i)
        }
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
