//
//  Feeds.swift
//  Bakirapp
//
//  Created by Silouanos on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit

struct Feeds
{
    static let baseUrl = "http://192.168.88.84:8000"
    static let login = Feeds.baseUrl + "/api/api-token-auth/"
    
    static let accounts = Feeds.baseUrl + "/api/my/accounts/"
    
}
