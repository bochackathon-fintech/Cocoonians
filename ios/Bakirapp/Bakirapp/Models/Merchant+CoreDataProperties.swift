//
//  Merchant+CoreDataProperties.swift
//  Bakirapp
//
//  Created by Silouanos on 11/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData


extension Merchant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Merchant> {
        return NSFetchRequest<Merchant>(entityName: "Merchant")
    }

    @NSManaged public var merchant_id: Int64
    @NSManaged public var merchant_remote_id: Int64
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var type_icon: String?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension Merchant {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
