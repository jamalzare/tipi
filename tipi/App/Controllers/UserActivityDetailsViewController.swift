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
    
    let goingBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.text = "GOING!"
        btn.backgroundColor =  UIColor(red:1, green:0.18, blue:0.33, alpha:1)
        btn.contentMode = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    func registerCells(){
        collectionView.register(UserActivityHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCell")
        collectionView.register(UserActivityDetailCell.self, forCellWithReuseIdentifier: "DetailCell")
        collectionView.register(AppBundle.AttendersCellNib, forCellWithReuseIdentifier: "AttendersCell")
        collectionView.register(AppBundle.MapCellNib, forCellWithReuseIdentifier: "MapCell")
        
        
    }
    
    func setup(){
        view.addSubview(collectionView)
        view.addSubview(goingBtn)
        registerCells()
        addConstaraints()
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadUserActivity()
        
    }
    
}

//MARK: constraints
extension UserActivityDetailsViewController{
 
    
    func setCollectionViewConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50).isActive = true
        
    }
    
    func setGoingBtnConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        goingBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        goingBtn.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        goingBtn.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        goingBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    func addConstaraints(){
        setCollectionViewConstraints()
        setGoingBtnConstraints()
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
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCell", for: indexPath) as! UserActivityHeaderCell
        header.imageUrl =  userActivityDetail?.image
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 375)
    }
    
    func dequeueDetailCell(collectionView: UICollectionView, indexPath: IndexPath)-> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as! UserActivityDetailCell
        cell.detail = userActivityDetail
        return cell
    }
    
    func dequeueAttendersCell(collectionView: UICollectionView, indexPath: IndexPath)-> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttendersCell", for: indexPath) as! AttendersCell
        cell.attenders = userActivityDetail?.attendees ?? []
        return cell
    }
    
    
    func dequeueMapCell(collectionView: UICollectionView, indexPath: IndexPath)-> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCell", for: indexPath) as! MapCell
        //cell.attenders = userActivityDetail?.attendees ?? []
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        switch indexPath.item {
        case 0:
            return dequeueDetailCell(collectionView: collectionView, indexPath: indexPath)
            
        case 1:
            return dequeueAttendersCell(collectionView: collectionView, indexPath: indexPath)
        case 2:
            return dequeueMapCell(collectionView: collectionView, indexPath: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    func calculateSizeForDetailCell(collectionView:UICollectionView)-> CGSize{
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return calculateSizeForDetailCell(collectionView: collectionView)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 238)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 232)
        default:
            return CGSize.zero
        }
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

