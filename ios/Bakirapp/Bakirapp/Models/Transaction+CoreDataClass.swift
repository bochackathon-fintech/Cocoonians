//
//  Transaction+CoreDataClass.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {
    
    static let className = "Transaction"
    
    /**
     @NSManaged public var amount: Float
     @NSManaged public var transaction_date: NSDate
     @NSManaged public var tags: String?
     @NSManaged public var descr: String
     @NSManaged public var account: Account?
     @NSManaged public var type: TransactionType?
     */
    
    class func create(context: NSManagedObjectContext, json: [String : Any]) -> Transaction? {
        guard let transactionId = json["transaction_id"] as? Int else {
            return nil
        }
        
        let request = NSFetchRequest<Transaction>(entityName: Transaction.className)
        request.predicate = NSPredicate(format: "transaction_id = %d", transactionId)
        
        do {
            if let object = (try context.fetch(request).last ??
                NSEntityDescription.insertNewObject(forEntityName: className, into: context)) as? Transaction
            {
                object.parse(json: json)
                return object
            }
        }
        catch {
            print(error)
        }
        
        return nil
    }
    
    func parse(json: [String : Any])
    {
        if let amountStr = json["amount"] as? String,
            let amountFloat = Float(amountStr)
        {
            self.amount = amountFloat
        }
        
        if let descr = json["description"] as? String {
            self.descr = descr
        }
        
        if let transaction_date_str = json["transaction_date"] as? String,
            let transaction_date = Date.getDateFromString("", dateString: transaction_date_str) {
            self.transaction_date = transaction_date as NSDate
        }
        
        if let tags = json["tags"] as? String {
            self.tags = tags
        }
    }
    
}
