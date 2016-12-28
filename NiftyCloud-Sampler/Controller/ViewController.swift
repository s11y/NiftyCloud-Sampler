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

enum NCMBCreateType {
    case Create
    case Update
}

class ViewController: UIViewController {

    @IBOutlet var table: UITableView!

    var books: [Books] = []

    var action: ActionButton!

    var updateBook: Books!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "bookCell")
        self.setActionButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.estimatedRowHeight = 71
        table.rowHeight = UITableViewAutomaticDimension
        self.read()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if NCMBUser.current() == nil {
            self.performSegue(withIdentifier: "toSignupView", sender: nil)
        }
    }

    func read() {
        Books.loadAll { (objects) in
            //booksという配列に取得したデータを入れる
            self.books = objects
            //TableViewをリフレッシュ
            self.table.reloadData()
        }
    }

    func deleteObject(indexPath: IndexPath) {
        let object = books[indexPath.row]
        object.deleteEventually { (error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
    }

    func transition() {
        self.performSegue(withIdentifier: "toAddView", sender: nil)
    }

    func toAddWithData(data: Books)  {
        self.performSegue(withIdentifier: "toAddView", sender: data)
    }

    func toAutherList() {
        self.performSegue(withIdentifier: "toAutherList", sender: nil)
    }

    func toAddAuther() {
        self.performSegue(withIdentifier: "toAddAutherView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddView" && sender != nil{
            let addView = segue.destination as! AddViewController
            addView.mode = .Update
            addView.updateBook = sender as! Books
        }
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
        action.setTitle("+", forState: .normal)
        action.backgroundColor = UIColor(red: 238/255, green: 130/255, blue: 34/255, alpha: 1)
    }
}
