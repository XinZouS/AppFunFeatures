//
//  PhotoBrowserZoomAnimator.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import UIKit

/// Zoom动画命名空间
public class PhotoBrowserZoomAnimator: NSObject {
    /// 转场时做动画效果的视图
    public var zoomView: () -> UIView?
    
    /// 动画开始位置
    public var startFrame: (_ transContainer: UIView) -> CGRect?
    
    /// 动画结束位置
    public var endFrame: (_ transContainer: UIView) -> CGRect?
    
    /// 初始化，三个回调中，只要有一个返回nil值，就无法执行zoom动画，将转为执行Fade动画。
    public init(zoomView: @escaping () -> UIView?,
                startFrame: @escaping (_ superView: UIView) -> CGRect?,
                endFrame: @escaping (_ superView: UIView) -> CGRect?) {
        self.zoomView = zoomView
        self.startFrame = startFrame
        self.endFrame = endFrame
    }
}


// MARK: -

public class PhotoBrowserZoomDismissingAnimator: PhotoBrowserZoomAnimator, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 转场容器
        let containerView = transitionContext.containerView
        guard let zView = zoomView(),
            let sFrame = startFrame(containerView),
            let eFrame = endFrame(containerView) else {
                // 转为执行Fade动画
                fadeTransition(using: transitionContext)
                return
        }
        // 把当前视图隐藏，只显示zoomView
        if let view = transitionContext.view(forKey: .from) {
            view.isHidden = true
        }
        containerView.addSubview(zView)
        zView.frame = sFrame
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            zView.frame = eFrame
        }) { _ in
            zView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    private func fadeTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = self.transitionDuration(using: transitionContext)
        if let view = transitionContext.view(forKey: .from) {
            UIView.animate(withDuration: duration, animations: {
                view.alpha = 0
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}


// MARK: -

public class PhotoBrowserZoomPresentingAnimator: PhotoBrowserZoomAnimator, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 转场容器
        let containerView = transitionContext.containerView
        guard let zView = zoomView(),
            let sFrame = startFrame(containerView),
            let eFrame = endFrame(containerView) else {
                // 转为执行Fade动画
                fadeTransition(using: transitionContext)
                return
        }
        containerView.addSubview(zView)
        zView.frame = sFrame
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            zView.frame = eFrame
        }) { _ in
            // presentation转场时，需要把目标视图添加到视图栈
            if let presentedView = transitionContext.view(forKey: .to) {
                containerView.addSubview(presentedView)
            }
            zView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    private func fadeTransition(using transitionContext: UIViewControllerContextTransitioning) {
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

