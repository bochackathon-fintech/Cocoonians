//
//  AccountCategory+CoreDataClass.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AccountCategory)
public class AccountCategory: NSManagedObject {
    static let className = "AccountCategory"
    
    class func create(context:NSManagedObjectContext,code:String, name:String) -> AccountCategory? {
        let className = AccountCategory.className
        
        let request = NSFetchRequest<AccountCategory>(entityName: className)
        request.predicate = NSPredicate(format: "code = %s", code)
        
        do {
            let object = (try context.fetch(request).last ??
                NSEntityDescription.insertNewObject(forEntityName: className, into: context)) as? AccountCategory
            
            object?.code = code
            object?.name = name
            try context.save()
            return object
            
        }
        catch {
            print(error)
        }
        
        
        return nil
        
        
    }

}
