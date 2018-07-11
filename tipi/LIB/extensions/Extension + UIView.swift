//
//  Extension + UIView.swift
//  tipi
//
//  Created by Jamal on 7/10/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit

extension UIView{
    
    
    func addSubViews(_ views: UIView...){
        for view in views{
            self.addSubview(view)
        }
    }
    
    func setSubViewMatchConstraints(for view: UIView, constant:CGFloat = 0){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor, constant: constant).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor, constant: constant).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor, constant: constant).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: constant).isActive = true
    }
    
    
    func setSubViewsHorizontalConstraints(for subViews:UIView..., constant:CGFloat = 0){
        for view in subViews{
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constant).isActive = true
        }
    }
    
    
    func setSubViewsVerticalConstraints(for subViews:UIView..., constant:CGFloat = 0){
        for view in subViews{
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: constant).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -constant).isActive = true
        }
    }
    
}
