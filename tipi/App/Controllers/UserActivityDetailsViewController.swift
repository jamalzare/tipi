//
//  UserActivityDetailsViewController.swift
//  tipi
//
//  Created by Jamal on 7/10/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit


class UserActivityDetailsViewController: UIViewController{
    
    var activityDocKey: String?
    var userActivityDetail: UserActivity?
    
    let collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    
    func registerCells(){
        collectionView.register(UserActivityHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCell")
        collectionView.register(UserActivityDetailCell.self, forCellWithReuseIdentifier: "DetailCell")
        
    }
    
    func addConstaraints(){
        
        let safeArea = view.safeAreaLayoutGuide
        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
    }
    
    func setup(){
        view.addSubview(collectionView)
        registerCells()
        addConstaraints()
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadUserActivity()
        
    }
    
}

//MARK:Apies
extension UserActivityDetailsViewController{
    
    func updateUi(model: UserActivity){
        userActivityDetail = model
        collectionView.reloadData()
    }
    
    func loadUserActivity() {
        UserActivityService.sharedInstance.getUserActivitDetails(docKey: activityDocKey ?? ""){dto  in
            self.updateUi(model: dto.model!)
        }
    }
    
}


//MARK: collection view
extension UserActivityDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCell", for: indexPath) as! UserActivityHeaderCell
        header.imageUrl =  userActivityDetail?.image
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 375)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let identifier = "DetailCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! UserActivityDetailCell
        cell.detail = userActivityDetail
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        var height:CGFloat = 120
        
        let text = userActivityDetail?.description ?? ""
        let font = UIFont.systemFont(ofSize: 15)
        
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        
        height = height + label.frame.height
        
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
}

