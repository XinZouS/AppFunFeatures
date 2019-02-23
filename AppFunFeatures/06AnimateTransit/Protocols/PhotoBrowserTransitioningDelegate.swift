//
//  PhotoBrowserTransitioningDelegate.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import UIKit

/// 转场动画代理
public protocol PhotoBrowserTransitioningDelegate: UIViewControllerTransitioningDelegate {
    
    /// 实现者应弱引用 PhotoBrowser，由 PhotoBrowser 初始化完毕后注入
    var browser: PhotoBrowser? { set get }
    
    /// 蒙板 alpha 值
    var maskAlpha: CGFloat { set get }
}
