//
//  SignUpViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/21.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signup() {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
