//
//  UserActivityDetailCell.swift
//  tipi
//
//  Created by Jamal on 7/10/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit

class UserActivityDetailCell: BaseCell {
    
    var detail: UserActivity?{
        didSet{
            imageView.setImageFromUrl(detail?.userAvatar)
            titleLabel.text = detail?.title
            descriptionLabel.text = detail?.description
        }
    }
    
    let headView:UIView = {
        return UIView()
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = iv.bounds.width/2
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.text = "Beach"
        lbl.font = UIFont(name: "SFProDisplay-Bold", size: 26)
        lbl.font = UIFont.systemFont(ofSize: 26)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let timeIconimageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "TimeIcon")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    let atLabel: UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.text = "18 MAR, 20:30"
        lbl.font = UIFont(name: "SFProText-Regular", size: 13)
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 4
        lbl.sizeToFit()
        lbl.font = UIFont(name: "SFProText-Regular", size: 15)
        lbl.font = UIFont.systemFont(ofSize: 15)
        
        return lbl
    }()
    
    func setSubViews(){
        headView.addSubViews(imageView, titleLabel, timeIconimageView, atLabel)
        addSubViews(headView, descriptionLabel)
    }
    
    func design(){
        imageView.layer.cornerRadius = imageView.bounds.height/2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        design()
    }
    
    override func initialize() {
        super.initialize()
        setSubViews()
        setConstraints()
    }
}

// MARK: Constraints
extension UserActivityDetailCell{
    func setConstraintForImageView(){
        imageView.topAnchor.constraint(equalTo: headView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: headView.leadingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setConstraintForTitleLabel(){
        titleLabel.topAnchor.constraint(equalTo: headView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12).isActive = true
    }
    
    func setConstraintForTimeIcon(){
        timeIconimageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        timeIconimageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        timeIconimageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        timeIconimageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func setConstraintForAtLabel(){
        atLabel.lastBaselineAnchor.constraint(equalTo: timeIconimageView.bottomAnchor, constant: -2).isActive = true
        
        atLabel.leadingAnchor.constraint(equalTo: timeIconimageView.trailingAnchor, constant: 5).isActive = true
    }
    
    func setConstraints(){
        
        setSubViewsHorizontalConstraints(for: headView, descriptionLabel, constant: 12)
        addConstraintsWithFormat("V:|-20-[v0(60)]-20-[v1]-20-|", views: headView, descriptionLabel)
        
        setConstraintForImageView()
        setConstraintForTitleLabel()
        setConstraintForTimeIcon()
        setConstraintForAtLabel()
    }
}
