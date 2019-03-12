//
//  PropertyAnimatorViewController.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 3/12/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class PropertyAnimatorViewController: UIViewController {
    
    // for advance animations
    let imageView = UIImageView()
    let slider = UISlider()
    let visualView = UIVisualEffectView(effect: nil)
    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupVisualEffectView()
        setupSlider()
        setupAnimator()
    }
    
    fileprivate func setupImageView() {
        self.view.addSubview(imageView)
        imageView.anchorCenterIn(self.view, width: 200, height: 200)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "567-1")
    }
    
    fileprivate func setupVisualEffectView() {
        self.view.addSubview(visualView)
        visualView.fillSuperview()
    }
    
    fileprivate func setupSlider() {
        self.view.addSubview(slider)
        slider.addTarget(self, action: #selector(sliderDidChanged), for: .valueChanged)
        slider.anchor(left: imageView.leftAnchor, top: imageView.bottomAnchor, right: imageView.rightAnchor, bottom: nil, leftConstent: 0, topConstent: 10, rightConstent: 0, bottomConstent: 0, width: 0, height: 0)
    }
    
    @objc fileprivate func sliderDidChanged(sld: UISlider) {
        print(sld.value)
        animator.fractionComplete = CGFloat(sld.value)
    }
    
    fileprivate func setupAnimator() {
        animator.addAnimations {
            // completed animation state
            self.imageView.transform = CGAffineTransform(scaleX: 4, y: 4)
            self.visualView.effect = UIBlurEffect(style: .light)
        }
    }
    
    
}
