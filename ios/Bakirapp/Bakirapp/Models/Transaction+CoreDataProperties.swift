//
//  Transaction+CoreDataProperties.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }
    
    @NSManaged public var transaction_id: Int
    @NSManaged public var amount: Float
    @NSManaged public var transaction_date: NSDate
    @NSManaged public var tags: String?
    @NSManaged public var descr: String
    @NSManaged public var account: Account?
    @NSManaged public var type: TransactionType?

}
