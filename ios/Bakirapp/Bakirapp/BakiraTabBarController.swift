//
//  ViewController.swift
//  Bakirapp
//
//  Created by Silouanos on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit

class BakiraTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.viewControllers.remove(at: 0)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"bell"), style: .done, target: self, action: #selector(BakiraTabBarController.goToPromotions))
        
    }
    
    func goToPromotions() {
        self.selectedIndex = 1
    }
    
}

