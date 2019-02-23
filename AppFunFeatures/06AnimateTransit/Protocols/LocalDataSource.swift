//
//  LocalDataSource.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import UIKit

open class LocalDataSource<T: PhotoBrowserBaseCell>: NSObject, PhotoBrowserDataSource {
    
    /// 弱引用 PhotoBrowser
    open weak var browser: PhotoBrowser?
    
    /// 共有多少项
    open var numberOfItemsCallback: () -> Int
    
    /// Cell重用时回调
    public var reuseCallback: ((T, Int) -> Void)?
    
    /// 每一项的图片对象
    open var localImageCallback: (Int) -> UIImage?
    
    /// 初始化
    public init(numberOfItems: @escaping () -> Int,
                localImage: @escaping (Int) -> UIImage?) {
        self.numberOfItemsCallback = numberOfItems
        self.localImageCallback = localImage
    }
    
    /// 配置重用Cell，回调(Cell, Index)
    public func configReusableCell(reuse: ((_ cell: T, _ index: Int) -> Void)?) {
        reuseCallback = reuse
    }
    
    /// 注册Cell
    public func registerCell(for collectionView: UICollectionView) {
        collectionView.jx.registerCell(T.self)
    }
    
    //
    // MARK: - UICollectionViewDataSource
    //
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsCallback()
    }
    
    /// Cell复用
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.jx.dequeueReusableCell(T.self, for: indexPath)
        cell.imageView.image = localImageCallback(indexPath.item)
        cell.setNeedsLayout()
        reuseCallback?(cell, indexPath.item)
        return cell
    }
}

extension UICollectionView: NamespaceWrappable {}

extension TypeWrapperProtocol where WrappedType == UICollectionView {
    
    /// 注册Cell
    public func registerCell<T: UICollectionViewCell>(_ type: T.Type) {
        let identifier = String(describing: type.self)
        wrappedValue.register(type, forCellWithReuseIdentifier: identifier)
    }
    
    /// 取重用Cell
    public func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: type.self)
        guard let cell = wrappedValue.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("\(type.self) was not registered")
        }
        return cell
    }
}
