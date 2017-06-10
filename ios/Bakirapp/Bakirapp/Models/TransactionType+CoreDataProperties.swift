//
//  TransactionType+CoreDataProperties.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData


extension TransactionType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionType> {
        return NSFetchRequest<TransactionType>(entityName: "TransactionType")
    }
    
    @NSManaged public var transaction_type_id: Int
    @NSManaged public var code: String
    @NSManaged public var name: String
    @NSManaged public var isDebit: Bool
    @NSManaged public var icon: String?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension TransactionType {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
