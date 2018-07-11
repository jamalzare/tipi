//
//  DetailCollectionViewLayout.swift
//  tipi
//
//  Created by Jamal on 7/11/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import UIKit


class UserActivityHeaderLayout: UICollectionViewFlowLayout{
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        let offsetY = collectionView!.contentOffset.y
        let delta = abs(offsetY)
        
        for attr in layoutAttributes!{
            if let elementKind = attr.representedElementKind{
                
                if elementKind == UICollectionElementKindSectionHeader{
                    
                    var frame = attr.frame
                    if offsetY<0{
                        frame.size.height = max(0, frame.size.height + delta)
                        frame.origin.y = frame.minY - delta
                    }else{
                        frame.origin.y = frame.minY + (delta/2)
                        attr.zIndex = -1
                    }
                    attr.frame = frame
                    
                }
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
