//
//  AppBundle.swift
//  tipi
//
//  Created by Jamal on 7/8/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit

struct BunldleItem{
    var controllerIdentifier:String
    var storyboard: String
}

class AppBundle{
    
    static var Login: BunldleItem{
        return BunldleItem(controllerIdentifier: "LoginViewController", storyboard: "Main")
    }
    
    static var UserActivity: BunldleItem{
        return BunldleItem(controllerIdentifier: "UserActivityViewController", storyboard: "Main")
    }
    
    static func getController(bundleItem: BunldleItem)-> UIViewController{
        
        let controller = UIApplication.getViewController(identifier: bundleItem.controllerIdentifier, stroyboard: bundleItem.storyboard) ?? UIViewController()
        return controller
        
    }
    
}


//MARK: view controller
extension AppBundle{
    
    class var LoginController: LoginViewController {
        return getController(bundleItem: Login) as! LoginViewController
    }
    
    class var UserActivityViewController: UserActivityViewController {
        return getController(bundleItem: UserActivity) as! UserActivityViewController
    }
    
    class var UserActivityDetailsController: UserActivityDetailsViewController {
        return  UserActivityDetailsViewController()
    }
    
}

//MARK: nib files
extension AppBundle{
    
    class var UserActiviyCellNib: UINib{
       return UINib(nibName: "UserActivitiesCell", bundle: nil) 
    }
    
    class var AttendersCellNib: UINib{
        return UINib(nibName: "AttendersCell", bundle: nil)
    }
    
    class var AttenderCellNib: UINib{
        return UINib(nibName: "AttenderCell", bundle: nil)
    }
    
    class var MapCellNib: UINib{
        return UINib(nibName: "MapCell", bundle: nil)
    }

}
