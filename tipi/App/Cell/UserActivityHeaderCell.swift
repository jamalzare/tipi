//
//  UserActivityHeaderCell.swift
//  tipi
//
//  Created by Jamal on 7/10/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit


class UserActivityHeaderCell: BaseCell{
    
    var imageUrl : String? {
        didSet{
            imageView.setImageFromUrl(imageUrl)
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .green
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "loadingImage.png")
        return iv
    }()
    
    
    func addConstraints(){
        setSubViewMatchConstraints(for: imageView)
    }
    
    
    func design(){
        self.backgroundColor = .red
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        design()
    }
    
    override func initialize() {
        super.initialize()
        addSubview(imageView)
        addConstraints()
    }
}
