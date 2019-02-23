//
//  FbLikeAnimationViewController.swift
//  CoreDataSetup
//
//  Created by Xin Zou on 12/8/18.
//  Copyright © 2018 Xin Zou. All rights reserved.
//

import UIKit

class FbLikeAnimationViewController: UIViewController {
    
    let iconContainerView = UIView()
    var selectedIndex: Int?
    let padding: CGFloat = 6
    let subViewH: CGFloat = 40
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        
        setupIconContainerView()
        setupLongPressGesture()
    }
    
    // view cycle
    
    private func setupIconContainerView() {
        
        let subViews: [UILabel] = ["❤️", "😂", "🤔", "😯", "🙈", "💩"].map { (icon) -> UILabel in
            let v = UILabel()
            v.isUserInteractionEnabled = true
            v.font = UIFont.systemFont(ofSize: 30)
            v.layer.cornerRadius = subViewH / 2
            v.clipsToBounds = true
            v.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            v.textAlignment = .center
            v.text = icon
            return v
        }
        // container size
        let h: CGFloat = subViewH + padding * 2
        let w: CGFloat = subViewH * CGFloat(subViews.count) + padding * CGFloat(subViews.count + 1)
        self.view.addSubview(iconContainerView)
        iconContainerView.backgroundColor = .white
        iconContainerView.frame = CGRect(x: 0, y: 0, width: w, height: h)
        iconContainerView.layer.cornerRadius = h / 2
        iconContainerView.layer.shadowRadius = 8
        iconContainerView.layer.shadowOpacity = 0.5
        iconContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = padding
        //⚠️ use layout setup didnot work...
//        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
//        stackView.isLayoutMarginsRelativeArrangement = true
        iconContainerView.addSubview(stackView)
        stackView.fillSuperview(padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }
    
    
    fileprivate func setupLongPressGesture() {
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            longPressDidBegan(gesture)
        } else if gesture.state == .ended {
            longPressDidEnd()
        } else if gesture.state == .changed {
            longPressDidChanged(gesture)
        }
    }
    
    private func longPressDidBegan(_ gesture: UILongPressGestureRecognizer) {
        guard let v = self.view else { return }
        
        let pressLocation = gesture.location(in: v)
        let padding: CGFloat = 20
        let containerMidX = iconContainerView.frame.midX
        let containerHeigh = iconContainerView.bounds.height
        
        let x = min(max(padding, pressLocation.x - containerMidX + padding), v.bounds.maxX - iconContainerView.bounds.width - padding)
        let y = max(containerHeigh + padding, pressLocation.y - containerHeigh - padding)
        
        // pre state
        iconContainerView.isHidden = false
        iconContainerView.alpha = 0
        iconContainerView.transform = CGAffineTransform(translationX: x, y: y + iconContainerView.bounds.height)
        
        // post state
        UIView.animate(withDuration: 0.5) {
            self.iconContainerView.transform = CGAffineTransform(translationX: x, y: y)
            self.iconContainerView.alpha = 1
        }
    }
    
    private func longPressDidEnd() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            if let stackView = self.iconContainerView.subviews.first {
                stackView.subviews.forEach({ (label) in
                    label.transform = .identity
                })
            }
            self.iconContainerView.alpha = 0
            let moveBack = self.iconContainerView.transform.translatedBy(x: 0, y: self.iconContainerView.bounds.height)
            self.iconContainerView.transform = moveBack
            
        }) { (_) in
            self.iconContainerView.isHidden = true
            print("did select item index: \(self.selectedIndex ?? -1)")
        }
    }
    
    private func longPressDidChanged(_ gesture: UILongPressGestureRecognizer) {
        let pressLocation = gesture.location(in: iconContainerView)
        let fixedYLocation = CGPoint(x: pressLocation.x, y: self.iconContainerView.frame.height / 2)
        let hitTestView = iconContainerView.hitTest(fixedYLocation, with: nil)
        
        selectedIndex = Int(pressLocation.x) / Int(subViewH + padding)
        
        if hitTestView is UILabel {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                // animate down other views back original position
                if let stackView = self.iconContainerView.subviews.first {
                    stackView.subviews.forEach({ (label) in
                        label.transform = .identity
                    })
                }
                // animate up the hitted view
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
            })
        }
    }
    
    
}
