//
//  AddViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/19.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class AddViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var dateTextField: UITextField!
    
    @IBOutlet var autherTextField: UITextField!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    @IBOutlet var imageView: UIImageView!
    
    var authers: [Authers] = []
    
    var auther: Authers!
    
    var datePicker: UIDatePicker!
    
    var picker: UIPickerView!
    
    var publishedDate: NSDate!
    
    var isPublic: Int! = 0
    
    var originalImage: UIImage!
    
    var imagePicker: UIImagePickerController!
    
    var mode: NCMBCreateType = .Create
    
    var updateBook: Books!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.read()
        titleTextField.delegate = TextFieldDelegate()
        segmentControl.addTarget(self, action: #selector(self.decideIsPublic(_:)), forControlEvents: .TouchUpInside)
        self.setDatePicker()
        self.setPickerView()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.selectImage))
        imageView.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if mode == .Update {
            self.displayRawData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayRawData() {
        self.titleTextField.text = updateBook.title
        self.autherTextField.text = updateBook.auther.familyName + updateBook.auther.familyName
        self.dateTextField.text = updateBook.publishedDate.convert()
        self.segmentControl.selectedSegmentIndex = updateBook.isPublic
    }
    
    @IBAction func didSelectAdd() {
        guard let title = titleTextField.text else { return }
        guard let date = publishedDate else { return }
        guard let whichPublic = self.isPublic else { return }
        guard let autherObject = self.auther else { return }
        switch mode {
        case .Update:
            self.updateObject(title, date: date, isPublic: whichPublic, autherObject: autherObject)
        case .Create:
            self.create(title, date: date, whichPublic: whichPublic, autherObject: autherObject)
        }
        
    }
    
    func selectImage() {
        print("select image")
        let alert = UIAlertController(title: "写真を選択", message: "どちらから写真を取得しますか？", preferredStyle: .ActionSheet)
        let camera = UIAlertAction(title: "カメラ", style: .Default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .Camera
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        let library = UIAlertAction(title: "フォトライブラリー", style: .Default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        alert.addAction(camera)
        alert.addAction(library)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func create(title: String, date: NSDate, whichPublic: Int, autherObject: Authers) {
        Books.create(title, date: date, isPublic: whichPublic, user: NCMBUser.currentUser(), auther: autherObject).saveWithEvent {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func updateObject(title: String, date: NSDate, isPublic: Int, autherObject: Authers) {
        Books.update(updateBook, user: NCMBUser.currentUser(), title: title, date: date, isPublic: isPublic, auther: autherObject).saveWithEvent { 
            self.navigationController?.popViewControllerAnimated(true)
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
        dateTextField.text = datePicker.date.convert()
        self.publishedDate = datePicker.date
    }
}
