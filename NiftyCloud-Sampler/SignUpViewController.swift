//
//  SignUpViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/21.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    @IBOutlet var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = TextFieldDelegate()
        passwordTextField.delegate = TextFieldDelegate()
        nameTextField.delegate = TextFieldDelegate()
        confirmPasswordTextField.delegate = TextFieldDelegate()
        passwordTextField.secureTextEntry = true
        confirmPasswordTextField.secureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectSignup() {
        guard let email = emailTextField.text else { return }
        guard let pass = passwordTextField.text else { return }
        guard let name = nameTextField.text else { return }
        guard let confirm = confirmPasswordTextField.text else { return }
//        if confirm.
        self.signup(email, password: pass, username: name)
    }
    
    @IBAction func didSelectToLogin() {
        self.transition()
    }
    
    func signup(mail: String, password: String, username: String) {
        let user = NCMBUser(className: "user")
        user.password = password
        user.mailAddress = mail
        user.userName = username
        if user.isNew == true {
            user.signUpInBackgroundWithBlock { (error) in
                if error != nil {
                    print(error.localizedDescription)
                }else {
                    NCMBUser.requestAuthenticationMailInBackground(mail, block: { (error) in
                        if error != nil {
                            print(error.localizedDescription)
                        }else {
                            self.transition()
                        }
                    })
                }
            }
        }else {
            print("ユーザーネームかぶっているよ")
        }
    }
    
    func transition() {
        self.performSegueWithIdentifier("toLoginView", sender: nil)
    }
}
