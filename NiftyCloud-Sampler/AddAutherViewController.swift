//
//  AddAutherViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/20.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class AddAutherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var firstTextField: UITextField!
    
    @IBOutlet var familyTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        familyTextField.delegate = self
        firstTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectSave() {
        
    }
    
    func create(first text: String, family str: String) {
        let auther = Authers(firstName: text, familyName: str)
        auther.saveEventually { (error) in
            if error != nil {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
