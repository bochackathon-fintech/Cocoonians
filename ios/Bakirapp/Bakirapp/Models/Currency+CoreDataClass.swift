//
//  Currency+CoreDataClass.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Currency)
public class Currency: NSManagedObject {
    
    static let className = "Currency"
    
    class func create(context:NSManagedObjectContext,code:String, name:String) -> Currency? {
        let className = Currency.className
        
        let request = NSFetchRequest<Currency>(entityName: className)
        request.predicate = NSPredicate(format: "code = %s", code)
        
        do {
            let object = (try context.fetch(request).last ??
                NSEntityDescription.insertNewObject(forEntityName: className, into: context)) as? Currency
            
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
