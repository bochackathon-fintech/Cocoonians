//
//  Transaction+Parse.swift
//  Bakirapp
//
//  Created by Silouanos on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit
import Alamofire

extension Transaction {
    //http://127.0.0.1:8000/api/my/transactions?account_id=1&start_date=01-01-2017&end_date=30-01-2017
    class func fetchTransactions()
    {
        guard let headers = Feeds.headers else {
            return
        }
        print("headers \(headers)")
        print("transactions \(Feeds.transactions)")
        Alamofire.request(Feeds.transactions, method: .get, headers: headers).responseJSON { (response) in
            ContextManager.shared.privateContext.perform {
                if let JSON = response.result.value as? [String : Any],
                let results = JSON["results"] as? [[String : Any]]
                {
                    _ = results.map({
                        if let trans = Transaction.create(context: ContextManager.shared.privateContext, json: $0) {
                            print("--> \(trans.descr)")
                        }
                    })
                }
            }
        }
        
    }
}

