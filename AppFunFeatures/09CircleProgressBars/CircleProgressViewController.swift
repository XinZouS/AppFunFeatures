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
    
    let layerOne = ProgressLayer()
    let layerTwo = ProgressLayer()
    let layerThree = ProgressLayer()
    let layerFour = ProgressLayer()
    
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
        layerOne.number = Double(slider.value)
        layerTwo.number = Double(slider.value)
        layerThree.number = Double(slider.value)
        layerFour.number = Double(slider.value)
    }
    
}

// 圆形进度条的父类，用于显示百分比文本
class ProgressLayer: CALayer {
    
    var number: Double = 0.0 {
        didSet {
            txtLayer.string = String(format: "%.01f%%", number * 100) // show 66.6%
            txtLayer.setNeedsDisplay()
        }
    }
    
    let txtLayer: CATextLayer = {
        let l = CATextLayer()
        let font = UIFont.systemFont(ofSize: 12)
        l.font = font.fontName as CFTypeRef
        l.fontSize = font.pointSize
        l.foregroundColor = UIColor.blue.cgColor
        l.alignmentMode = CATextLayerAlignmentMode.center
        l.contentsScale = UIScreen.main.scale
        l.isWrapped = true
        l.string = ""
        return l
    }()
    
    override init() {
        super.init()
        addSublayer(txtLayer)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        
        let atts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        let tH = NSString(string: "100%").boundingRect(with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: atts, context: nil).height
        
        txtLayer.frame = CGRect(x: 0, y: frame.height * 0.5 - tH * 0.5, width: frame.width, height: tH)
    }
}
