//
//  SnapShot+CoreDataProperties.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//
//

import Foundation
import CoreData


extension SnapShot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SnapShot> {
        return NSFetchRequest<SnapShot>(entityName: "SnapShot")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var balance: Float
    @NSManaged public var account: Account?

}
 
