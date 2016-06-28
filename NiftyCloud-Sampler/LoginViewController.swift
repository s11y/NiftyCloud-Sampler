//
//  LoginViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/21.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = TextFieldDelegate()
        passwordTextField.delegate = TextFieldDelegate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectLogin() {
        guard let mail = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        self.login(mail, password: password)
    }
    
    func login(mail: String, password: String) {
        NCMBUser.logInWithMailAddressInBackground(mail, password: password) { (user, error) in
            if error != nil {
                print(error.localizedDescription)
            }else {
                if user.isAuthenticated() {
                    
                }
            }
        }
    }
}
