//
//  ContextManager.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ContextManager {
    static let shared = ContextManager()
    
    lazy var application:UIApplication = {
        return UIApplication.shared
    }()
    
    lazy var mainContext:NSManagedObjectContext = {
        return (self.application.delegate as! AppDelegate).managedObjectContext
    }()
    
    lazy var privateContext:NSManagedObjectContext = {
        return (self.application.delegate as! AppDelegate).managedObjectContext
    }()
}
