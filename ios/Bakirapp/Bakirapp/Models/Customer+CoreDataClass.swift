//
//  Customer+CoreDataClass.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Customer)
public class Customer: NSManagedObject {
    static let className = "Customer"
    
    class func create(context:NSManagedObjectContext, customer_number:String, email:String, first_name:String, last_name:String) -> Customer? {
        let className = Customer.className
        
        let request = NSFetchRequest<Customer>(entityName: className)
        request.predicate = NSPredicate(format: "customer_number = %@", customer_number)
        
        do {
            let object = (try context.fetch(request).last ??
                NSEntityDescription.insertNewObject(forEntityName: className, into: context)) as? Customer
            
            object?.customer_number = customer_number
            object?.email = email
            object?.first_name = first_name
            object?.last_name = last_name
            
            try context.save()
            return object
            
        }
        catch {
            print(error)
        }
        
        
        return nil
        
        
    }
}
