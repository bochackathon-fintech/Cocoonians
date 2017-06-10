//
//  TransactionType+CoreDataClass.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TransactionType)
public class TransactionType: NSManagedObject {
    
    static let className = "TransactionType"
    
    /**
     @NSManaged public var transaction_type_id: Int
     @NSManaged public var code: String
     @NSManaged public var name: String
     @NSManaged public var isDebit: Bool
     @NSManaged public var icon: String?
     @NSManaged public var transactions: NSSet?
     
     */
    
    class func create(context: NSManagedObjectContext, json: [String : Any]) -> TransactionType?
    {
        guard let transactionTypeId = json["id"] as? Int else {
            return nil
        }
        let request = NSFetchRequest<TransactionType>(entityName: TransactionType.className)
        request.predicate = NSPredicate(format: "transaction_type_id = %d", transactionTypeId)
        
        do {
            if let object = (try context.fetch(request).last ??
                NSEntityDescription.insertNewObject(forEntityName: TransactionType.className, into: context)) as? TransactionType
            {
                object.parse(json: json, transactionTypeId: transactionTypeId, context: context)
                try context.save()
                return object
            }
        }
        catch {
            print(error)
        }
        
        return nil
        
    }
    
    
    
    func parse(json: [String : Any], transactionTypeId: Int, context: NSManagedObjectContext) {
        /**
         "id": 3,
         "code": "3",
         "name": "Credit Card",
         "isDebit": true,
         "icon": "http://192.168.88.84:8000/media/type_icons/Credit.png"
         */
        
        print("transaction type \(json)")
        
        self.transaction_type_id = transactionTypeId
        
        if let code = json["code"] as? String {
            print("tt code \(code)")
            self.code = code
        }
        
        if let name = json["name"] as? String {
            print("tt name \(name)")
            self.name = name
        }
        
        if let isDebit = json["isDebit"] as? Bool {
            print("tt isDebit \(isDebit)")
            self.isDebit = isDebit
        }
        
        if let icon = json["icon"] as? String {
            print("tt icon \(icon)")
            self.icon = icon
        }
    }
}
