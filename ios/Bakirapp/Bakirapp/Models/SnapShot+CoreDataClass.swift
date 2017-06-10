//
//  SnapShot+CoreDataClass.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SnapShot)
public class SnapShot: NSManagedObject {
    
    static let className = "SnapShot"
    
    class func create(context:NSManagedObjectContext,account:Account, balance:Float, date:Date) -> SnapShot? {
        let className = SnapShot.className
        
        let request = NSFetchRequest<SnapShot>(entityName: className)
        request.predicate = NSPredicate(format: "date = %@", date as NSDate)
        
        do {
            let object = (try context.fetch(request).last ??
                NSEntityDescription.insertNewObject(forEntityName: className, into: context)) as? SnapShot
            
            object?.account = account
            object?.balance = balance
            object?.date = date as NSDate
            
            try context.save()
            return object
            
        }
        catch {
            print(error)
        }
        
        
        return nil
        
        
    }
    
}
