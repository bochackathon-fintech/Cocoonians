//
//  Account+Parse.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

extension Account {
    
    class func fetchAccounts(completion:@escaping (_ success:Bool, _ accounts:[Account]?)->Void){
        if let token = KeychainWrapper.standard.string(forKey: Keys.token) {
            let headers: HTTPHeaders = [
                "Authorization": "Token \(token)",
                "Accept": "application/json"
            ]
            
            Alamofire.request(Feeds.accounts, method: .get, headers: headers).responseJSON { (response) in
                
                ContextManager.shared.privateContext.perform {
                    if let JSON = response.result.value as? [String : Any] {
                        guard let category_data = JSON["category"] as? [String:Any],
                            let cat_code = category_data["code"] as? String,
                            let cat_name = category_data["name"] as? String,
                            let category = AccountCategory.create(context: ContextManager.shared.privateContext, code: cat_code, name: cat_name) else {
                                completion(false, nil)
                                return
                        }
                        
                        guard let currency_data = JSON["currency"] as? [String:Any],
                            let cur_code = category_data["code"] as? String,
                            let cur_name = category_data["name"] as? String,
                            let currency = Currency.create(context: ContextManager.shared.privateContext, code: cur_code, name: cur_name) else {
                                completion(false, nil)
                                return
                        }
                        
                        
                    }
                }
            }
            
        }
        else{
            completion(false, nil)
        }
        
    }
    
    func parseData(){
        
    }
}
