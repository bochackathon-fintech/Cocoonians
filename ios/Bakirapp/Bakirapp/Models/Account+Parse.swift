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
    
    func fetchAccounts(completion:(_ success:Bool, _ accounts:[Account]?)->Void){
        if let token = KeychainWrapper.standard.string(forKey: Keys.token) {
            let headers: HTTPHeaders = [
                "Authorization": "Token \(token)",
                "Accept": "application/json"
            ]
            
//            Alamofire.request(Feeds.accounts, method: .get, headers: [""])
            //        Alamofire.request(Feeds.accounts, method: .get, parameters: params).responseJSON { (response) in
            //        }
            
        }
        else{
            completion(false, nil)
        }
        
    }
    
    func parseData(){
        
    }
}
