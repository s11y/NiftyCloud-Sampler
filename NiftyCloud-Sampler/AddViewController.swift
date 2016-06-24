//
//  AddViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/19.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class AddViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var autherTextField: UITextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    var authers: [Authers] = []
    
    var auther: Authers!

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
//        guard let auther = autherTextField.text else { return }
        let book: Books = Books(title: title, publishedDate: date, auther: authers[0], isPublic: 0)
        book.saveEventually { (error) in
            if error != nil {
                // 失敗
            }else {
                // 成功
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func setPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource  = self
        autherTextField.inputView = pickerView
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return authers.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.auther = self.authers[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
