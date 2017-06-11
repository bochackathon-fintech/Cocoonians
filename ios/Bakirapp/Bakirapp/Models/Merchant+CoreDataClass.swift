//
//  Merchant+CoreDataClass.swift
//  Bakirapp
//
//  Created by Silouanos on 11/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Merchant)
public class Merchant: NSManagedObject {
    
    static let className = "Merchant"
    
    class func create(context: NSManagedObjectContext, json: [String : Any]) -> Merchant?
    {
        guard let merchantId = json["id"] as? Int else {
            return nil
        }
        let request = NSFetchRequest<Merchant>(entityName: Merchant.className)
        request.predicate = NSPredicate(format: "merchant_remote_id = %d", merchantId)
        
        do {
            if let object = (try context.fetch(request).last ??
                NSEntityDescription.insertNewObject(forEntityName: Merchant.className, into: context)) as? Merchant
            {
                object.parse(json: json, merchantId: merchantId)
                try context.save()
                return object
            }
        }
        catch {
            print(error)
        }
        return nil
    }
    
    private func parse(json: [String : Any], merchantId: Int)
    {
        self.merchant_remote_id = Int64(merchantId)
        
        if let name = json["name"] as? String {
            self.name = name
        }
        
        if let merchantId = json["merchant_id"] as? Int {
            self.merchant_id = Int64(merchantId)
        }
        
        if let typeJson = json["type"] as? [String : Any],
            let typeName = typeJson["type"] as? String {
            self.type = typeName
        }
        if let typeJson = json["type"] as? [String : Any],
            let typeIcon = typeJson["icon"] as? String {
            self.type_icon = typeIcon
        }
        
        
        
    }
    
}
