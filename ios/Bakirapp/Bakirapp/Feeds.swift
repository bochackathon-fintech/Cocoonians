//
//  Feeds.swift
//  Bakirapp
//
//  Created by Silouanos on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

struct Feeds
{
    static let baseUrl = "http://192.168.88.84:8000"
    static let login = Feeds.baseUrl + "/api/api-token-auth/"
    
    static let accounts = Feeds.baseUrl + "/api/my/accounts/"
    
    //TODO: To be changed.
    static let transactions = Feeds.baseUrl + "/api/my/transactions/?account_id=1&start_date=01-01-2017&end_date=30-06-2017"
    
    
    static var headers: HTTPHeaders? {
        guard let token = KeychainWrapper.standard.string(forKey: Keys.token) else {
            return nil
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Token \(token)",
            "Accept": "application/json"
        ]
        return headers
    }
}
