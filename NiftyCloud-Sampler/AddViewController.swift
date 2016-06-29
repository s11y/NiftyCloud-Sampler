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
    
    @IBOutlet var dateTextField: UITextField!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    var authers: [Authers] = []
    
    var auther: Authers!
    
    var datePicker: UIDatePicker!
    
    var publishedDate: NSDate!
    
    var isPublic: NSNumber!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = TextFieldDelegate()
        autherTextField.delegate = TextFieldDelegate()
        segmentControl.addTarget(self, action: #selector(self.decideIsPublic(_:)), forControlEvents: .TouchUpInside)
        self.setDatePicker()
        self.setPickerView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.read()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectAdd() {
        self.create()
    }
    
    func create() {
        guard let title = titleTextField.text else { return }
        guard let date = publishedDate else { return }
        guard let whichPublic = self.isPublic else { return }
        guard let auther = self.auther else { return }
        let book = Books.create(titleOfBook: title, publishedDate: date, autherOfBook: auther, isPublic: whichPublic, user: NCMBUser.currentUser())
        book.saveWithEvent()
    }
    
    func read() {
        authers = Authers.loadAll()
    }
    
    func decideIsPublic(row: Int) {
        self.isPublic = NSNumber(integer: row)
    }
    
    func setDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .Date
        datePicker.addTarget(self, action: #selector(self.convertDateToDate), forControlEvents: .ValueChanged)
        dateTextField.inputView = datePicker
    }
    
    func convertDateToDate() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateTextField.text = dateFormatter.stringFromDate(datePicker.date)
        self.publishedDate = datePicker.date
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
        self.autherTextField.text = "\(self.auther.familyName) \(self.auther.firstName)"
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
}
