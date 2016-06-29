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
    
    var books: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.registerNib(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "BookCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
                for object in objects {
                    self.books.append(object)
                }
                self.table.reloadData()
            }
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
        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell") as! BookCell
        
        let book = books[indexPath.row]
        cell.titleLabel.text = book.title
        cell.publishedDateLabel.text = (book["publishedDate"] as! NSDate).convert()
        
        return cell
    }
}

