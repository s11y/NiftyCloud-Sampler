//
//  ViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/12.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB
import ActionButton

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    var books: [Books] = []
    
    var action: ActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.delegate = self
        table.dataSource = self
        table.registerNib(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "bookCell")
        self.setActionButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        table.estimatedRowHeight = 71
        table.rowHeight = UITableViewAutomaticDimension
        self.read()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if NCMBUser.currentUser() == nil {
            self.performSegueWithIdentifier("toSignupView", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func read() {
        let query = NCMBQuery(className: "Books")
        query.whereKeyExists("title")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil {
                print(error.localizedDescription)
            }else {
                self.books.removeAll()
                for object in objects {
                    if let thing: Books = object as? Books {
                        self.books.append(thing)
                    }
                }
                self.table.reloadData()
            }
        }
    }
    
    func transition() {
        self.performSegueWithIdentifier("toAddView", sender: nil)
    }
    
    func toAutherList() {
        self.performSegueWithIdentifier("toAutherList", sender: nil)
    }
    
    func toAddAuther() {
        self.performSegueWithIdentifier("toAddAutherView", sender: nil)
    }
    
    func setActionButton() {
        let editBtn = ActionButtonItem(title: "Add", image: UIImage(named: "edit"))
        let autherBtn = ActionButtonItem(title: "Auther", image: UIImage(named: "avatar"))
        let addAutherBtn = ActionButtonItem(title: "Add Auther", image: UIImage(named: "avatar_edit"))
        editBtn.action = { item in
            self.transition()
        }
        autherBtn.action = { item in
            self.toAutherList()
        }
        addAutherBtn.action = { item in
            self.toAddAuther()
        }
        action = ActionButton(attachedToView: self.view, items: [editBtn, autherBtn, addAutherBtn   ])
        action.action = { button in
            button.toggleMenu()
        }
        action.setTitle("+", forState: .Normal)
        action.backgroundColor = UIColor(red: 238/255, green: 130/255, blue: 34/255, alpha: 1)
    }
}

