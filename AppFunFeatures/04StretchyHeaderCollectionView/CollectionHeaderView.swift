//
//  CollectionHeaderView.swift
//  CoreDataSetup
//
//  Created by Xin Zou on 1/15/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit


class CollectionHeaderView: UICollectionReusableView {
    
    var animator: UIViewPropertyAnimator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setupImageView()
        setupVisualEffectBlur()
    }
    
    private func setupImageView() {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "567-1")
        img.contentMode = .scaleAspectFill
        addSubview(img)
        img.fillSuperview()
    }
    
    private func setupVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: { [weak self] in
            // treat this part as the end of animation
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            
            self?.addSubview(visualEffectView)
            visualEffectView.fillSuperview()
        })
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

