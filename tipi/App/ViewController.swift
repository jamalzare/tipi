//
//  ViewController.swift
//  tipi
//
//  Created by Jamal on 7/7/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var userActivities = [UserActivity]()
    
    
    func setup(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "UserActivitiesCell", bundle: nil) ,forCellWithReuseIdentifier: "Cell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        LoginService.sharedInstance.login(){ [weak self] in
            self?.loadUserActivities()
        }
        
        
    }
    
}

//MARK:Apies
extension ViewController{
    
    func updateUi(list: [UserActivity]){
        userActivities.append(contentsOf: list)
        collectionView.reloadData()
    }
    
    func loadUserActivities() {
        LoginService.sharedInstance.getList{ dto in
            self.updateUi(list: dto.list)
        }
    }
}

//MARK: CollectionView
extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return userActivities.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! UserActivitiesCell
        
        let activity = userActivities[indexPath.item]
        cell.activity = activity
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
}

