//
//  PromotionsSingleton.swift
//  Bakirapp
//
//  Created by Silouanos on 11/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit

class PromotionsSingleton
{
    static let shared = PromotionsSingleton()
    
    var possiblePromos = [Promo]()
    
    let promos:[Promo] =
        [Promo(image: UIImage(named:"Baby")!, title: "Expecting?", description: "Your new baby is on its way. Open the baby savings account and prepare for a bright future!", type: .newbaby),
         Promo(image: UIImage(named:"Car")!, title: "Looking for a new car?", description: "A bigger family calls for a bigger car. You could be sitting behind the steering wheel of your new car faster than you might have imagined.", type: .newbaby),
         Promo(image: UIImage(named:"Holidays")!, title: "You’re going on a trip!", description: "Book your travel insurance for your trip and get rewarded with double points on your credit card!", type: .vacation),
         Promo(image: UIImage(named:"Raise")!, title: "You got a raise! Congrats!", description: "Open a new savings account and take advantage of our great interest rates. ", type: .raise),
         Promo(image: UIImage(named:"Wedding")!, title: "You’re getting married!", description: "Open the newlyweds account and save for a brighter future together.", type: .wedding)
    ]
    
    func lookForPossiblePromos(promo type: PromoType) {
        
        let matchingPromos = self.promos.filter({$0.type == type})
        if matchingPromos.count == 0 {
            return
        }
        
        let context = ContextManager.shared.mainContext
        let transactions = Transaction.getTransactions(context: context, usingMerchantType: type.rawValue)
        
        if type == .newbaby {
            if transactions.count >= 2 {
                self.possiblePromos.removeAll()
                self.possiblePromos += matchingPromos
            }
        }
        
        
        
    }
}
