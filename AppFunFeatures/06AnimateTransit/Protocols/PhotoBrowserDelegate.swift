//
//  PhotoBrowserDelegate.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import UIKit

/// 视图代理
public protocol PhotoBrowserDelegate: UICollectionViewDelegate {
    
    /// 实现者应弱引用 PhotoBrowser，由 PhotoBrowser 初始化完毕后注入
    var browser: PhotoBrowser? { set get }
    
    /// pageIndex 值改变时回调
    func photoBrowser(_ browser: PhotoBrowser, pageIndexDidChanged pageIndex: Int)
    
    /// 取当前显示页的内容视图。比如是 ImageView.
    func displayingContentView(_ browser: PhotoBrowser, pageIndex: Int) -> UIView?
    
    /// 取转场动画视图
    func transitionZoomView(_ browser: PhotoBrowser, pageIndex: Int) -> UIView?
    
    /// viewDidLoad 即将结束时调用
    func photoBrowserViewDidLoad(_ browser: PhotoBrowser)
    
    /// viewWillAppear 即将结束时调用
    func photoBrowser(_ browser: PhotoBrowser, viewWillAppear animated: Bool)
    
    /// viewWillLayoutSubviews 即将结束时调用
    func photoBrowserViewWillLayoutSubviews(_ browser: PhotoBrowser)
    
    /// viewDidLayoutSubviews 即将结束时调用
    func photoBrowserViewDidLayoutSubviews(_ browser: PhotoBrowser)
    
    /// viewDidAppear 即将结束时调用
    func photoBrowser(_ browser: PhotoBrowser, viewDidAppear animated: Bool)
    
    /// viewWillDisappear 即将结束时调用
    func photoBrowser(_ browser: PhotoBrowser, viewWillDisappear animated: Bool)
    
    /// viewDidDisappear 即将结束时调用
    func photoBrowser(_ browser: PhotoBrowser, viewDidDisappear animated: Bool)
    
    /// 关闭
    func dismissPhotoBrowser(_ browser: PhotoBrowser)
    
    /// 数据源已刷新
    func photoBrowserDidReloadData(_ browser: PhotoBrowser)
}
