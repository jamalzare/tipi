//
//  LoginViewController.swift
//  tipi
//
//  Created by Jamal on 7/8/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    
    func design(){
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setup(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        login()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        design()
    }
    
}

//MARK:Apies
extension LoginViewController{
    
    func navigateToUserActivities(){
        navigationController?.pushViewController(AppBundle.UserActivityViewController, animated: true)
    }
    
    
    func login(){
        LoginService.sharedInstance.login(){ [weak self] in
            self?.navigateToUserActivities()
        }
    }
}
