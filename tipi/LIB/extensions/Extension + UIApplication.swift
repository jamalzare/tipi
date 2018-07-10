//
//  Extension + UIApplication.swift
//  tipi
//
//  Created by Jamal on 7/8/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit
extension UIApplication {
    
    class func getViewController(identifier:String, stroyboard:String)->UIViewController?
    {
        let board = UIStoryboard.init(name: stroyboard, bundle: nil)
        return board.instantiateViewController(withIdentifier: identifier)
    }
}
