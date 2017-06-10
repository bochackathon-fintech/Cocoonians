//
//  Account+CoreDataProperties.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var account_number: String
    @NSManaged public var name: String
    @NSManaged public var overdraft_limit: Double
    @NSManaged public var balance: Double
    @NSManaged public var opening_date: NSDate
    @NSManaged public var currency: Currency
    @NSManaged public var category: AccountCategory
    @NSManaged public var customer: Customer
    @NSManaged public var snapshots: NSSet?

}

// MARK: Generated accessors for snapshots
extension Account {

    @objc(addSnapshotsObject:)
    @NSManaged public func addToSnapshots(_ value: SnapShot)

    @objc(removeSnapshotsObject:)
    @NSManaged public func removeFromSnapshots(_ value: SnapShot)

    @objc(addSnapshots:)
    @NSManaged public func addToSnapshots(_ values: NSSet)

    @objc(removeSnapshots:)
    @NSManaged public func removeFromSnapshots(_ values: NSSet)

}
