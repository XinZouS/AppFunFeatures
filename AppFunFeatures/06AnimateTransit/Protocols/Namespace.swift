//
//  Namespace.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

/// 类型协议
public protocol TypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedValue: WrappedType { get }
    init(value: WrappedType)
}

public struct NamespaceWrapper<T>: TypeWrapperProtocol {
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}

/// 命名空间协议
public protocol NamespaceWrappable {
    associatedtype WrappedType
    var jx: WrappedType { get }
    static var jx: WrappedType.Type { get }
}

extension NamespaceWrappable {
    public var jx: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }
    
    public static var jx: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}
