//
//  AddAutherViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/20.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

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
    
    @IBAction func didSelectSave() {
        guard let family = familyTextField.text else { return }
        guard let first = firstTextField.text else { return }
        let auther = Authers.create(first: first, family: family)
        auther.saveInBackground()
    }
}
