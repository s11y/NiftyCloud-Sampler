//
//  AddViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/19.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class AddViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    var originalImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.read()
        titleTextField.delegate = TextFieldDelegate()
        segmentControl.addTarget(self, action: #selector(self.decideIsPublic(_:)), forControlEvents: .TouchUpInside)
        self.setDatePicker()
        self.setPickerView()
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    @IBAction func selectImage() {
        let alert = UIAlertController(title: "写真を選択", message: "どちらから写真を取得しますか？", preferredStyle: .ActionSheet)
        let camera = UIAlertAction(title: "", style: .Default) { (action) in
            
        }
        
        let library = UIAlertAction(title: "", style: .Default) { (action) in
            
        }
        
        alert.addAction(camera)
        alert.addAction(library)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func create() {
        guard let title = titleTextField.text else { return }
        guard let date = publishedDate else { return }
        guard let whichPublic = self.isPublic else { return }
        guard let autherObejct = self.auther else { return }
        let book = Books.create(title, date: date, isPublic: whichPublic, user: NCMBUser.currentUser(), auther: autherObejct)
        book.saveEventually { (error) in
            if error != nil {
                print(error.localizedDescription)
            }else {
                self.navigationController?.popViewControllerAnimated(true)
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
                print(self.authers)
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
        
        autherTextField.inputAccessoryView = toolBar
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
        dateTextField.inputAccessoryView = toolBar
    }
    
    func convertDateToDate() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateTextField.text = dateFormatter.stringFromDate(datePicker.date)
        self.publishedDate = datePicker.date
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.originalImage = image
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return authers.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return authers[row].familyName + authers[row].firstName
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.auther = self.authers[row]
        self.autherTextField.text = "\(self.auther.familyName) \(self.auther.firstName)"
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
}
