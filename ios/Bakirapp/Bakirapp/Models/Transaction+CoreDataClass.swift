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
    
    class func create(context: NSManagedObjectContext, json: [String : Any]) -> Transaction? {
        guard let transactionId = json["id"] as? Int else {
            return nil
        }
        let request = NSFetchRequest<Transaction>(entityName: Transaction.className)
        request.predicate = NSPredicate(format: "transaction_id = %d", transactionId)
        
        do {
            guard let account_data = json["account"] as? [String : Any],
                let accounNumber = account_data["acount_number"] as? String,
                let account = Account.findAccount(context: context, accountNumber: accounNumber) else {
//                self.account = account
                    return nil
            }
            
            guard let transaction_type = json["transaction_type"] as? [String : Any],
                let trans_type = TransactionType.create(context: context, json: transaction_type) else {
//                self.type = trans_type
                    return nil
            }
            
            if let object = (try context.fetch(request).last ??
                NSEntityDescription.insertNewObject(forEntityName: Transaction.className, into: context)) as? Transaction
            {
                object.parse(json: json, transactionId: transactionId, account: account, transactionType: trans_type, context: context)
                try context.save()
                return object
            }
        }
        catch {
            print(error)
        }
        
        return nil
    }
    
    func parse(json: [String : Any], transactionId: Int, account: Account, transactionType: TransactionType, context: NSManagedObjectContext)
    {
        self.transaction_id = transactionId
        self.account = account
        self.type = transactionType
        
        if let amountStr = json["amount"] as? String,
            let amountFloat = Float(amountStr)
        {
            self.amount = amountFloat
        }
        
        if let descr = json["description"] as? String {
            self.descr = descr
        }
        
        if let transaction_date_str = json["transaction_date"] as? String,
            let transaction_date = transaction_date_str.toDate {
            self.transaction_date = transaction_date as NSDate
        }
        
        if let tags = json["tags"] as? String {
            self.tags = tags
        }
    }
    
}
