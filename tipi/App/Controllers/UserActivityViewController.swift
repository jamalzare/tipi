//
//  ViewController.swift
//  tipi
//
//  Created by Jamal on 7/7/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit


class UserActivityViewController: UIViewController {

    var userActivities = [UserActivity]()
    
    
    func setup(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AppBundle.UserActiviyCellNib, forCellWithReuseIdentifier: "Cell")
        collectionView.contentInset = UIEdgeInsets.zero
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadUserActivities()
        
    }
    
}

//MARK:Apies
extension UserActivityViewController{
    
    func updateUi(list: [UserActivity]){
        userActivities.append(contentsOf: list)
        collectionView.reloadData()
    }
    
    func loadUserActivities() {
        UserActivityService.sharedInstance.getList{ dto in
            self.updateUi(list: dto.list)
        }
    }
    
}

//MARK: CollectionView
extension UserActivityViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
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
        let width = collectionView.bounds.width
        let hasAttender = userActivities[indexPath.item].hasAttender
        return CGSize(width:  width, height: hasAttender ? 400: 400-40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = AppBundle.UserActivityDetailsController
        controller.activityDocKey = userActivities[indexPath.item].docKey
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

