//
//  PhotoBrowserFadePresentingAnimator.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import UIKit

public class PhotoBrowserFadePresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        if let view = transitionContext.view(forKey: .to) {
            // presentation转场，需要把目标视图添加到视图栈
            containerView.addSubview(view)
            view.alpha = 0
            UIView.animate(withDuration: duration, animations: {
                view.alpha = 1.0
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
