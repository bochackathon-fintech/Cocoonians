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
    
    class func create(context:NSManagedObjectContext,id:Int, acount_number:String, balance:Double, category:Category, currency:Currency, name:String, opening_date:Date, overdraft_limit:Double) -> Account? {
//        let className = AccountCategory.className
//        
//        let request = NSFetchRequest<AccountCategory>(entityName: className)
//        request.predicate = NSPredicate(format: "code = %s", code)
//        
//        do {
//            let object = (try context.fetch(request).last ??
//                NSEntityDescription.insertNewObject(forEntityName: className, into: context)) as? AccountCategory
//            
//            object?.code = code
//            object?.name = name
//            try context.save()
//            return object
//            
//        }
//        catch {
//            print(error)
//        }
//        
//        
        return nil
        
        
    }
    

}
