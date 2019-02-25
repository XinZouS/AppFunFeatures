//
//  PTHelpers.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

struct ConstraintInfo {
    var attribute: NSLayoutConstraint.Attribute = .left
    var secondAttribute: NSLayoutConstraint.Attribute = .notAnAttribute
    var constant: CGFloat = 0
    var identifier: String?
    var relation: NSLayoutConstraint.Relation = .equal
}

precedencegroup constOp {
    associativity: left
    higherThan: AssignmentPrecedence
}


// MARK: - tableview

extension UITableView {
    func getReusableCellWithIdentifier<T: UITableViewCell>(indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("[ERROR] Couldn't instantiate view controller with identifier \(T.cellIdentifier) ")
        }
        
        return cell
    }
}


// MARK: - UITableViewCell

protocol TableViewCellIdentifiable {
    static var cellIdentifier: String { get }
}

extension TableViewCellIdentifiable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: TableViewCellIdentifiable {}




/// MARK: - Time extension
func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}



infix operator >>>-: constOp

@discardableResult
func >>>- <T: UIView>(left: (T, T), block: (inout ConstraintInfo) -> Void) -> NSLayoutConstraint {
    var info = ConstraintInfo()
    block(&info)
    info.secondAttribute = info.secondAttribute == .notAnAttribute ? info.attribute : info.secondAttribute
    
    let constraint = NSLayoutConstraint(item: left.1,
                                        attribute: info.attribute,
                                        relatedBy: info.relation,
                                        toItem: left.0,
                                        attribute: info.secondAttribute,
                                        multiplier: 1,
                                        constant: info.constant)
    constraint.identifier = info.identifier
    left.0.addConstraint(constraint)
    return constraint
}

@discardableResult
func >>>- <T: UIView>(left: T, block: (inout ConstraintInfo) -> Void) -> NSLayoutConstraint {
    var info = ConstraintInfo()
    block(&info)
    
    let constraint = NSLayoutConstraint(item: left,
                                        attribute: info.attribute,
                                        relatedBy: info.relation,
                                        toItem: nil,
                                        attribute: info.attribute,
                                        multiplier: 1,
                                        constant: info.constant)
    constraint.identifier = info.identifier
    left.addConstraint(constraint)
    return constraint
}

@discardableResult
func >>>- <T: UIView>(left: (T, T, T), block: (inout ConstraintInfo) -> Void) -> NSLayoutConstraint {
    var info = ConstraintInfo()
    block(&info)
    info.secondAttribute = info.secondAttribute == .notAnAttribute ? info.attribute : info.secondAttribute
    
    let constraint = NSLayoutConstraint(item: left.1,
                                        attribute: info.attribute,
                                        relatedBy: info.relation,
                                        toItem: left.2,
                                        attribute: info.secondAttribute,
                                        multiplier: 1,
                                        constant: info.constant)
    constraint.identifier = info.identifier
    left.0.addConstraint(constraint)
    return constraint
}
