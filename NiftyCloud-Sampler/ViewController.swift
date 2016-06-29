//
//  ViewController.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/12.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import NCMB

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var books: [NCMBObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.delegate = self
        table.dataSource = self
        table.registerNib(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "bookCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        table.estimatedRowHeight = 71
        table.rowHeight = UITableViewAutomaticDimension
        self.read()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        self.read()
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
                print(objects)
                self.books.removeAll()
                for object in objects {
                    self.books.append(object as! NCMBObject)
                }
            }
            self.table.reloadData()
        }
        
    }
    
    @IBAction func didSelectAdd() {
        self.transition()
    }
    
    func transition() {
        self.performSegueWithIdentifier("toAddView", sender: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bookCell") as! BookCell
        
        let book = books[indexPath.row]
        print(book.objectForKey("title"))
        cell.titleLabel.text = "\(book.objectForKey("title"))"
        cell.publishedDateLabel.text = (book.objectForKey("publishedDate") as! NSDate).convert()
        
        return cell
    }
}

