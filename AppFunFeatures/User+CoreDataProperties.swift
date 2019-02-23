//
//  User+CoreDataProperties.swift
//  CoreDataSetup
//
//  Created by Xin Zou on 11/26/18.
//  Copyright © 2018 Xin Zou. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String!

}
