//
//  CADisplayLinkViewController.swift
//  CoreDataSetup
//
//  Created by Xin Zou on 12/10/18.
//  Copyright © 2018 Xin Zou. All rights reserved.
//

import UIKit

class CADisplayLinkViewController: UIViewController {
    
    private let numberLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupNumberLabel()
        createCADisplayLink()
    }
    
    private func setupNumberLabel() {
        numberLabel.text = "666"
        numberLabel.textColor = .blue
        numberLabel.textAlignment = .center
        numberLabel.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(numberLabel)
        numberLabel.anchorCenterIn(self.view, width: 100, height: 50)
    }
    
    
    var link: CADisplayLink?
    
    private func createCADisplayLink() {
        link = CADisplayLink(target: self, selector: #selector(handleUpdate))
        link?.add(to: .main, forMode: .default)
    }
    
    // MARK: - update animation
    private var startVal: Double = 600
    private let endVal: Double = 10000
    let animationDuration: Double = 1.5
    
    let animationStartDate = Date()
    
    @objc private func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        print("\(now): do update")
        
        if elapsedTime < animationDuration {
            let percentage = elapsedTime / animationDuration // 0%-100%
            let val = startVal + percentage * (endVal - startVal)
            self.numberLabel.text = "\(val)"
            
        } else {
            self.numberLabel.text = "\(endVal)"
            link?.remove(from: .main, forMode: .default)
        }
    }
    
    
}
