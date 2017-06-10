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
import LocalAuthentication

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var bakiraLogoImageView: UIImageView! {
        didSet {
            bakiraLogoImageView.isUserInteractionEnabled = true
            let doubleTabGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.bocLogoDoubleTouched))
            doubleTabGesture.numberOfTapsRequired = 2
            bakiraLogoImageView.addGestureRecognizer(doubleTabGesture)
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    deinit {
        self.removeNotifications()
    }

    private func configureNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.showFingerprintIfNeeded), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    private func removeNotifications()
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.layer.cornerRadius = 10.0
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
            print("response value \(String(describing: response.result.value))")

            if let JSON = response.result.value as? [String : Any],
                let token = JSON["token"] as? String
            {
                KeychainWrapper.standard.set(token, forKey: Keys.token)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "BakiraTabBarController")
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
        
    }
    
    func bocLogoDoubleTouched()
    {
        self.usernameTextField.text = "u45653"
        self.passwordTextField.text = "qwerty123"
    }
    
    func showFingerprintIfNeeded()
    {
        print("show fingerprint if needed")
        if UserDefaults.hasToken
        {
            let context = LAContext()
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
            {
                let localizedReasonString = NSLocalizedString("Session expired. Fingerprint authentication required", comment: "Session expired. Fingerprint authentication required")
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReasonString, reply: { (success, error) in
                    if success
                    {
                        DispatchQueue.main.async {
                            print("success \(success)")
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "BakiraTabBarController")
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                    }
                    else
                    {
                        context.invalidate()
                    }
                })
            }
            else
            {
                print("error \(String(describing: error?.debugDescription))")
            }
        }

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
