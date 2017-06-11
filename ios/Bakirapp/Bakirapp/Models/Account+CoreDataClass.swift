//
//  Account+CoreDataClass.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Account)
public class Account: NSManagedObject {
    
    static let className = "Account"
    
    class func create(context:NSManagedObjectContext, acount_number:String, balance:Double, category:AccountCategory, currency:Currency, name:String, opening_date:Date, overdraft_limit:Double, owner:Customer) -> Account? {
        let className = Account.className
        
        let request = NSFetchRequest<Account>(entityName: className)
        request.predicate = NSPredicate(format: "account_number = %@", acount_number)
        
        do {
            let object = (try context.fetch(request).last ??
                NSEntityDescription.insertNewObject(forEntityName: className, into: context)) as? Account
            
            object?.account_number = acount_number
            object?.balance = balance
            object?.category = category
            object?.currency = currency
            object?.name = name
            object?.customer = owner
            object?.opening_date = opening_date as NSDate
            
            try context.save()
            return object
            
        }
        catch {
            print(error)
        }
        return nil
    }
    
    class func findAccount(context: NSManagedObjectContext, accountNumber: String) -> Account?
    {
        let request = NSFetchRequest<Account>(entityName: className)
        request.predicate = NSPredicate(format: "account_number = %@", accountNumber)
        do {
            if let account = try context.fetch(request).first {
                return account
            }
        }
        catch {
            print(error)
        }
        return nil
    }
}
