//
//  SignUpViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/21.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB



class SignUpViewController: UIViewController{
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    @IBOutlet var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        confirmPasswordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        if confirm.isEqual(text: pass) {
            self.signup(mail: email, password: pass, username: name)
        }else {
            self.presentPassConfirmAlert()
        }
    }
    
    @IBAction func didSelectToLogin() {
        self.transition()
    }
    
    func signup(mail: String, password: String, username: String) {
        let user = NCMBUser(className: "user")
        user?.password = password
        user?.mailAddress = mail
        user?.userName = username
        if user?.isNew == false {
            user?.signUpInBackground { (error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }else {
                    self.requestAuthentication(email: mail)
                }
            }
        }else {
            print("ユーザーネームかぶっているよ")
            self.presentCheckUsernameAlert()
        }
    }
    
    func requestAuthentication(email address: String) {
        NCMBUser.requestAuthenticationMail(inBackground: address, block: { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }else {
                self.transition()
            }
        })
    }
    
    func presentPassConfirmAlert() {
        let alert = UIAlertController(title: "パスワードが一致しません", message: "パスワードが一致しなかったので、もう一度入力してください", preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default) { (action) in
            self.confirmPasswordTextField.text = ""
            self.passwordTextField.text = ""
        }
        alert.addAction(btn)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentCheckUsernameAlert()  {
        let alert = UIAlertController(title: "ユーザーネームエラー", message: "記入されたユーザーネームは既に登録されています。\n違うユーザーネームを記入してください", preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default) { (action) in
            self.nameTextField.text = ""
        }
        alert.addAction(btn)
        self.present(alert, animated: true, completion: nil)
    }
    
    func toView()  {
        self.performSegue(withIdentifier: "toView", sender: nil)
    }
    
    func transition() {
        self.performSegue(withIdentifier: "toLoginView", sender: nil)
    }
    
    
}
