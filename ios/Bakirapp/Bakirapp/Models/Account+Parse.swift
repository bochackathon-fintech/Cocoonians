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
                    if let JSON = response.result.value as? [String : Any], let results = JSON["results"] as? [[String : Any]]{                        
                        print(JSON)
                        var accounts:[Account] = []
                        for result in results{
                            guard let category_data = result["category"] as? [String:Any],
                                let cat_code = category_data["code"] as? String,
                                let cat_name = category_data["name"] as? String,
                                let category = AccountCategory.create(context: ContextManager.shared.privateContext, code: cat_code, name: cat_name) else {
                                    completion(false, nil)
                                    break
                            }
                            
                            guard let currency_data = result["currency"] as? [String:Any],
                                let cur_code = currency_data["code"] as? String,
                                let cur_name = currency_data["name"] as? String,
                                let currency = Currency.create(context: ContextManager.shared.privateContext, code: cur_code, name: cur_name) else {
                                    completion(false, nil)
                                    break
                            }
                            
                            guard let owner_data = result["owner"] as? [String:Any],
                                let customer_number = owner_data["customer_number"] as? String,
                                let email = owner_data["email"] as? String,
                                let first_name = owner_data["first_name"] as? String,
                                let last_name = owner_data["last_name"] as? String,
                                let owner = Customer.create(context: ContextManager.shared.privateContext, customer_number: customer_number, email: email, first_name: first_name, last_name: last_name) else {
                                    completion(false, nil)
                                    break
                            }
                            
                            if let acount_number = result["acount_number"] as? String,
                                let balance_str = result["balance"] as? String,
                                let balance = Double(balance_str),
                                let name = result["name"] as? String,
                                let overdraft_limit_str = result["ovedraft_limit"] as? String,
                                let overdraft_limit = Double(overdraft_limit_str),
                                let opening_date = (result["opening_date"] as? String)?.toDate,
                                let account = Account.create(context: ContextManager.shared.privateContext, acount_number: acount_number, balance: balance, category: category, currency: currency, name: name, opening_date: opening_date, overdraft_limit: overdraft_limit, owner: owner){
                                
                                accounts.append(account)
                            }
                        }
                        completion(true, accounts)
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
