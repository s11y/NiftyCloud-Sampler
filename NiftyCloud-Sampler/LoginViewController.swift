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
        
        passwordTextField.secureTextEntry = true
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
    
    @IBAction func selectForgetPassword() {
        self.presentEmailTextField()
    }
    
    func login(mail: String, password: String) {
        NCMBUser.logInWithMailAddressInBackground(mail, password: password) { (user, error) in
            if error != nil {
                print(error.localizedDescription)
            }else {
                if user.isAuthenticated() {
                    self.transition()
                }else {
                    self.presentAuthAlert()
                }
            }
        }
    }
    
    func requestResetPassword(email address: String) {
        NCMBUser.requestPasswordResetForEmailInBackground(address) { (error) in
            if error != nil {
                print(error.localizedDescription)
            }
        }
    }
    
    func presentEmailTextField() {
        let alert = UIAlertController(title: "パスワードをリセット", message: "パスワードをリセットするためのメールアドレスを記入してください", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Enter Email Address"
        }
        let btn = UIAlertAction(title: "Finish", style: .Default) { (action) in
            if let textField: UITextField = alert.textFields![0] {
                if let text = textField.text {
                    self.requestResetPassword(email: text)
                }else {
                    print("メールアドレスが記入されてないよ")
                }
                
            }
        }
        alert.addAction(btn)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func presentAuthAlert() {
        let alert = UIAlertController(title: "ユーザー認証失敗", message: "メールアドレスの認証を行ってください。", preferredStyle: .Alert)
        let btn = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(btn)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func transition() {
        self.performSegueWithIdentifier("toViewCon", sender: nil)
    }
}
