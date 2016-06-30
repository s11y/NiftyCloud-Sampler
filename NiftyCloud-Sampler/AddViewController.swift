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
    
    @IBOutlet var dateTextField: UITextField!
    
    @IBOutlet var autherTextField: UITextField!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    var authers: [Authers] = []
    
    var auther: Authers!
    
    var datePicker: UIDatePicker!
    
    var picker: UIPickerView!
    
    var publishedDate: NSDate!
    
    var isPublic: Int! = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = TextFieldDelegate()
        segmentControl.addTarget(self, action: #selector(self.decideIsPublic(_:)), forControlEvents: .TouchUpInside)
        self.setDatePicker()
        self.setPickerView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.read()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectAdd() {
        self.create()
    }
    
    @IBAction func didTapGeture() {
        titleTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
    }
    
    func create() {
        guard let title = titleTextField.text else { return }
        guard let date = publishedDate else { return }
        guard let whichPublic = self.isPublic else { return }
        let book = Books(className: "Books")
        book.title = title
        book.isPublic = whichPublic
        book.publishedDate = date
        book.user = NCMBUser.currentUser()
        book.saveEventually { (error) in
            if error != nil {
                print(error.localizedDescription)
            }
        }
    }
    
    func read() {
        let query = NCMBQuery(className: "Authers")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil {
                print(error.localizedDescription)
            }else {
                for object in objects {
                    self.authers.append(object as! Authers)
                }
            }
        }
    }
    
    func decideIsPublic(row: Int) {
        self.isPublic = row
    }
    
    func setPickerView() {
        self.picker = UIPickerView()
        self.picker.delegate = self
        self.addToolBar()
        autherTextField.inputView = picker
    }
    
    func setDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .Date
        datePicker.addTarget(self, action: #selector(self.convertDateToDate), forControlEvents: .ValueChanged)
        self.addDone()
        dateTextField.inputView = datePicker
    }
    
    func addToolBar() {
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height-20)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let toolBtn = UIBarButtonItem(title: "DONE", style: .Plain, target: self, action: #selector(resign))
        toolBar.items = [toolBtn]
    }
    
    func resign() {
        autherTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
    }
    
    func addDone() {
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height-20)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let doneBtn = UIBarButtonItem(title: "DONE", style: .Plain, target: self, action: #selector(resign))
        toolBar.items = [doneBtn]
    }
    
    func convertDateToDate() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateTextField.text = dateFormatter.stringFromDate(datePicker.date)
        self.publishedDate = datePicker.date
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return authers.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.auther = self.authers[row]
        self.autherTextField.text = "\(self.auther.familyName) \(self.auther.firstName)"
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
}
