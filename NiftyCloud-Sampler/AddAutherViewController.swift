//
//  AddAutherViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/20.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class AddAutherViewController: UIViewController {
    
    @IBOutlet var firstTextField: UITextField!
    
    @IBOutlet var familyTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        familyTextField.delegate = TextFieldDelegate()
        firstTextField.delegate = TextFieldDelegate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func create(first: String, family: String) {
        let auther = NCMBObject(className: "Authers")
        auther.setObject(first, forKey: "firstName")
        auther.setObject(family, forKey: "familyName")
        auther.saveEventually { (error) in
            if error != nil {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func didSelectSave() {
        guard let family: String = familyTextField.text else { return }
        guard let first: String = firstTextField.text else { return }
        self.create(first, family: family)
    }
}
