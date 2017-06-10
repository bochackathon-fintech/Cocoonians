//
//  AccountCategory+CoreDataProperties.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData


extension AccountCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountCategory> {
        return NSFetchRequest<AccountCategory>(entityName: "AccountCategory")
    }

    @NSManaged public var code: String
    @NSManaged public var name: String
    @NSManaged public var accounts: NSSet?

}

// MARK: Generated accessors for accounts
extension AccountCategory {

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: Account)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: Account)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSSet)

}
