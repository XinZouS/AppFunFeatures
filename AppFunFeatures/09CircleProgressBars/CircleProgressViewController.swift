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
    
    let layerOne = ProgressOneLayer()
    let layerTwo = ProgressTwoLayer()
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
        layerOne.number = CGFloat(slider.value)
        layerTwo.number = CGFloat(slider.value)
        layerThree.number = CGFloat(slider.value)
        layerFour.number = CGFloat(slider.value)
    }
    
}

// 圆形进度条的父类，用于显示百分比文本
class ProgressLayer: CALayer {
    
    var number: CGFloat = 0.0 {
        didSet {
            txtLayer.string = String(format: "%.01f%%", number * 100) // show 66.6%
            txtLayer.setNeedsDisplay()
            self.setNeedsDisplay() // 重绘txt和自己的环
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
        l.string = "0.0%"
        return l
    }()
    
    // MARK: - init
    
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
    
    // MARK: - layout contents
    
    override func layoutSublayers() {
        super.layoutSublayers()
        
        let atts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        let tH = NSString(string: "100%").boundingRect(with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: atts, context: nil).height
        
        txtLayer.frame = CGRect(x: 0, y: frame.height * 0.5 - tH * 0.5, width: frame.width, height: tH)
    }
}

// MARK: - different types of Circle bar

class ProgressOneLayer: ProgressLayer {
    
    override func draw(in ctx: CGContext) {
        let radius = frame.width * 0.45
        let center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        let startAngle: CGFloat = -0.5 * CGFloat.pi
        let endAngle:   CGFloat = -0.5 * CGFloat.pi + 2 * CGFloat.pi * number
            
        ctx.setStrokeColor(UIColor.cyan.cgColor)
        ctx.setLineWidth(radius * 0.08)
        ctx.setLineCap(CGLineCap.round)
        ctx.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        ctx.strokePath()
    }
    
}

class ProgressTwoLayer: ProgressLayer {
    
    override func draw(in ctx: CGContext) {
        let radius = frame.width * 0.45
        let center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        let startAngle: CGFloat = -0.5 * CGFloat.pi
        let endAngle:   CGFloat = -0.5 * CGFloat.pi + 2 * CGFloat.pi * number
        
        ctx.setFillColor(UIColor.yellow.cgColor)
        
        // 先画圆心到12点位置的直线（不然会填充错误）
        ctx.move(to: center)
        ctx.addLine(to: CGPoint(x: center.x, y: frame.height * 0.05))
        // 再画圆弧
        ctx.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        // 再闭合图形
        ctx.closePath()
        // 完成绘制（填充）
        ctx.fillPath()
    }
    
}
