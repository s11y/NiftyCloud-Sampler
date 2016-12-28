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

    var publishedDate: Date!

    var isPublic: Int! = 0

    var originalImage: UIImage!

    var imagePicker: UIImagePickerController!

    var mode: NCMBCreateType = .Create

    var updateBook: Books!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.read()
        titleTextField.delegate = self
        segmentControl.addTarget(self, action: #selector(AddViewController.decideIsPublic(row:)), for: .touchUpInside)
        self.setDatePicker()
        self.setPickerView()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.selectImage))
        imageView.addGestureRecognizer(gesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if mode == .Update {
            self.displayRawData()
        }
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
            self.updateObject(title: title, date: date, isPublic: whichPublic, autherObject: autherObject)
        case .Create:
            self.create(title: title, date: date, whichPublic: whichPublic, autherObject: autherObject)
        }

    }

    func selectImage() {
        let alert = UIAlertController(title: "写真を選択", message: "どちらから写真を取得しますか？", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "カメラ", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }

        let library = UIAlertAction(title: "フォトライブラリー", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }

        alert.addAction(camera)
        alert.addAction(library)
        self.present(alert, animated: true, completion: nil)

    }

    func create(title: String, date: Date, whichPublic: Int, autherObject: Authers) {
        //モデルクラスからcreateを呼び出し、その後、saveWithEventで保存処理を行う
        Books.create(title: title, date: date, isPublic: whichPublic, user: NCMBUser.current(), auther: autherObject).saveWithEvent {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

    func updateObject(title: String, date: Date, isPublic: Int, autherObject: Authers) {
        Books.update(object: updateBook, user: NCMBUser.current(), title: title, date: date, isPublic: isPublic, auther: autherObject).saveWithEvent {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

    func read() {
        Authers.loadAll { (objects) in
            self.authers = objects
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
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.convertDateToDate), for: .valueChanged)
        self.addDone()
        dateTextField.inputView = datePicker
    }

    func addToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height-20)
        toolBar.addDoneBtn(target: self, textField: autherTextField, selector: #selector(self.resign))
    }

    func resign() {
        autherTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
    }

    func addDone() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height-20)
        toolBar.addDoneBtn(target: self, textField: dateTextField, selector: #selector(self.resign))
    }

    func convertDateToDate() {
        dateTextField.text = datePicker.date.convert()
        self.publishedDate = datePicker.date
    }
}
