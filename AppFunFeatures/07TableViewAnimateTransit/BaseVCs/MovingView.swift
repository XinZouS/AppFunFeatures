//
//  MovingView.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//


import UIKit

internal enum MovingDirection {
    case up
    case down
}

internal protocol Moving: class {
    
    var defaultYPosition: CGFloat { get set }
    
    func move(_ duration: Double, direction: MovingDirection, completion: ((Bool) -> Void)?)
}

extension Moving where Self: UIView {
    
    func move(_ duration: Double, direction: MovingDirection, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.78,
                       initialSpringVelocity: 0,
                       options: UIView.AnimationOptions(),
                       animations: { [weak self] () -> Void in
                        guard let `self` = self else { return }
                        var toYPosition = self.defaultYPosition
                        if direction == .up {
                            self.defaultYPosition = self.frame.origin.y
                            var position: CGFloat = 20
                            if #available(iOS 11.0, *) {
                                if let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top {
                                    position = topPadding
                                }
                            }
                            toYPosition = position
                        }
                        self.frame = CGRect(x: 0, y: toYPosition, width: self.frame.size.width, height: self.frame.size.height)
            }, completion: completion)
    }
}

internal class MovingLabel: UILabel, Moving {
    var defaultYPosition: CGFloat = 0
}

internal class MovingView: UIView {
    var defaultYPosition: CGFloat = 0
    
    internal func move(_ duration: Double, direction: MovingDirection, distance: CGFloat, completion: ((Bool) -> Void)? = nil) {
        var yPosition = defaultYPosition - 2
        if direction == .down {
            defaultYPosition = frame.origin.y
            yPosition = distance
        }
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.78,
                       initialSpringVelocity: 0,
                       options: UIView.AnimationOptions(),
                       animations: { () -> Void in
                        self.frame.origin.y = yPosition
        }, completion: completion)
    }
}
