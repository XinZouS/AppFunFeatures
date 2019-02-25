//
//  PTDetailViewController.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

/// Base UIViewController for preview transition
open class PTDetailViewController: UIViewController {
    
    var bgImage: UIImage?
    var titleText: String?
    
    fileprivate var backgroundImageView: UIImageView?
}

// MARK: life cicle
extension PTDetailViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView = createBackgroundImage(bgImage)
        view.backgroundColor = .black
        
        if let titleText = self.titleText {
            title = titleText
        }
        
        // hack
        if let navigationController = self.navigationController {
            for case let label as UILabel in navigationController.view.subviews {
                label.isHidden = true
            }
        }
        
        _ = createNavBar(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
    }
}

// MARK: public
extension PTDetailViewController {
    
    /**
     Pops the top view controller from the navigation stack and updates the display with custom animation.
     */
    public func popViewController() {
        
        if let navigationController = self.navigationController {
            for case let label as UILabel in navigationController.view.subviews {
                label.isHidden = false
            }
        }
        _ = navigationController?.popViewController(animated: false)
    }
}

// MARK: create
extension PTDetailViewController {
    
    fileprivate func createBackgroundImage(_ image: UIImage?) -> UIImageView {
        
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.image = image
        imageView.frame = view.bounds
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(imageView, at: 0)
        
        return imageView
    }
    
    fileprivate func createNavBar(_ color: UIColor) -> UIView {
        let navBar = UIView(frame: CGRect.zero)
        navBar.backgroundColor = color
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
        
        for attributes: NSLayoutConstraint.Attribute in [.left, .right, .top] {
            (view, navBar) >>>- {
                $0.attribute = attributes
                return
            }
        }
        navBar >>>- {
            $0.attribute = .height
            var constant: CGFloat = 64
            if #available(iOS 11.0, *) {
                if let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top {
                    constant += topPadding
                }
            }
            $0.constant = constant
            return
        }
        
        return navBar
    }
}
