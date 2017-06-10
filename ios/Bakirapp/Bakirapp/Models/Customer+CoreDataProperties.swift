//
//  Customer+CoreDataProperties.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var customer_number: String
    @NSManaged public var email: String
    @NSManaged public var first_name: String
    @NSManaged public var last_name: String
    @NSManaged public var accounts: Account?

}
