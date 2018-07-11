//
//  AttendersCell.swift
//  tipi
//
//  Created by Jamal on 7/11/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit

class AttendersCell: UICollectionViewCell {

    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var linkLabel:UILabel!
    
    var attenders = [Attender](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    func  design()  {
        backgroundColor = .white
        linkLabel.textColor = UIColor(red:1, green:0.18, blue:0.33, alpha:1)
    }
    
    func setup(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AppBundle.AttenderCellNib, forCellWithReuseIdentifier: "Cell")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        design()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        // Initialization code
    }

}

extension AttendersCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return attenders.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! AttenderCell
        
        let attender = attenders[indexPath.item]
        cell.attender = attender
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width:  85, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


