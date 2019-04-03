//
//  CircleProgressViewController.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 4/3/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit


class CircleProgressViewController: UIViewController {
    
    let slider = UISlider(frame: .zero)
    
    let layerOne = CALayer()
    let layerTwo = CALayer()
    let layerThree = CALayer()
    let layerFour = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(slider)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.anchor(left: view.leftAnchor, top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, bottom: nil, leftConstent: 20, topConstent: 20, rightConstent: 20)
        
        view.layer.addSublayer(layerOne)
        view.layer.addSublayer(layerTwo)
        view.layer.addSublayer(layerThree)
        view.layer.addSublayer(layerFour)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let y: CGFloat = 110
        let margin: CGFloat = 30
        let lwh: CGFloat = 100
        let horSpace = (view.frame.width - 2 * lwh) / 3
        
        layerOne.frame =   CGRect(x: horSpace,           y: y, width: lwh, height: lwh)
        layerTwo.frame =   CGRect(x: horSpace * 2 + lwh, y: y, width: lwh, height: lwh)
        layerThree.frame = CGRect(x: horSpace,           y: y + lwh + margin, width: lwh, height: lwh)
        layerFour.frame =  CGRect(x: horSpace * 2 + lwh, y: y + lwh + margin, width: lwh, height: lwh)
    }
    
    @objc private func sliderValueChanged() {
        
    }
    
}
