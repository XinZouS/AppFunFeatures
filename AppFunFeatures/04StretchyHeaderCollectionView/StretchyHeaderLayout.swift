//
//  StretchyHeaderLayout.swift
//  CoreDataSetup
//
//  Created by Xin Zou on 1/15/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAtts = super.layoutAttributesForElements(in: rect)
        
        layoutAtts?.forEach({ (att) in
            if att.representedElementKind == UICollectionView.elementKindSectionHeader &&
                att.indexPath.section == 0 { // only adjust the 1st header
                
                guard let collectionView = collectionView else { return }
                
                let contentOffsetY = collectionView.contentOffset.y
                
                if contentOffsetY < 0 {
                    let width = collectionView.frame.width
                    // header adjust
                    let h = att.frame.height - contentOffsetY
                    att.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: h)
                }
            }
        })
        return layoutAtts
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
