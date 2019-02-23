//
//  PhotoBrowserDataSource.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import UIKit

/// 数据源
public protocol PhotoBrowserDataSource: UICollectionViewDataSource {
    
    /// 实现者应弱引用 PhotoBrowser，由 PhotoBrowser 初始化完毕后注入
    var browser: PhotoBrowser? { set get }
    
    /// 注册Cell
    func registerCell(for collectionView: UICollectionView)
}
