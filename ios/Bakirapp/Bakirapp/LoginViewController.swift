//
//  LoginViewController.swift
//  Bakirapp
//
//  Created by Silouanos on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var bocLogoImageView: UIImageView! {
        didSet {
            bocLogoImageView.isUserInteractionEnabled = true
            let doubleTabGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.bocLogoDoubleTouched))
            doubleTabGesture.numberOfTapsRequired = 2
            bocLogoImageView.addGestureRecognizer(doubleTabGesture)
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.layer.cornerRadius = 4.0
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = self.textFields.map({$0.resignFirstResponder()})
        return false
    }
    
    @IBAction func loginButtonTouched()
    {
        guard let usernameText = self.usernameTextField.text,
            let passwordText = self.passwordTextField.text else
        {
            return
        }
        
        let params: [String : Any] = ["username" : usernameText, "password" : passwordText]
        Alamofire.request(Feeds.login, method: .post, parameters: params).responseJSON { (response) in
            print("response \(response.result)")
            print("response value \(response.result.value)")

            if let JSON = response.result.value as? [String : Any],
                let token = JSON["token"] as? String
            {
                print("token: \(token) saved \(KeychainWrapper.standard.set(token, forKey: Keys.token))")
            }
        }
        
    }
    
    func bocLogoDoubleTouched()
    {
        self.usernameTextField.text = "u45653"
        self.passwordTextField.text = "qwerty123"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
