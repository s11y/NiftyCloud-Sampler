//
//  AddViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/19.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var autherTextField: UITextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var authers: [Authers] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        autherTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func create() {
        guard let title = titleTextField.text else { return }
        guard let date: NSDate = datePicker.date else { return }
        guard let auther = autherTextField.text else { return }
        let book = Books(title: title, publishedDate: date, auther: authers[0])
        book.saveEventually { (error) in
            if error != nil {
                // 失敗
            }else {
                // 成功
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
