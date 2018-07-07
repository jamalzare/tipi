//
//  Extension + UIImageView.swift
//  tipi
//
//  Created by Jamal on 7/7/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    public func setImageFromUrl(_ urlString:String?, defaultImage:UIImage? = nil)
    {
        let str = urlString ?? ""
        
        if str.isEmpty{
            self.image = defaultImage
            return
        }
        let url = URL(string: str)
        self.kf.setImage(with: url, placeholder: defaultImage, options: nil, progressBlock: nil, completionHandler: nil)
    }
}
