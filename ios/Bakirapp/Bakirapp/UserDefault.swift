//
//  UserDefault.swift
//  Bakirapp
//
//  Created by Silouanos on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

extension UserDefaults
{
    class func set(stringValue: String, forKey key: String)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(stringValue, forKey: key)
        userDefaults.synchronize()
    }
    
    class func getStringValue(forKey key: String) -> String?
    {
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: key) as? String {
            return value
        }
        else {
            return nil
        }
    }
    
    
    class func set(boolValue: Bool, forKey key: String)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(boolValue, forKey: key)
        userDefaults.synchronize()
    }
    
    class func getBoolValue(forKey key: String) -> Bool?
    {
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: key) as? Bool {
            return value
        }
        else {
            return nil
        }
    }

    class var hasToken: Bool {
        return KeychainWrapper.standard.hasValue(forKey: Keys.token)
    }
    
}
