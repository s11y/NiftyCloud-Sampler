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
    
    var books: [Books] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.registerNib(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "BookCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func read() {
        books = Books.loadAll()
        table.reloadData()
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
        cell.autherLabel.text = "\(book.auther.familyName) \(book.auther.firstName)"
        cell.titleLabel.text = book.title
        cell.publishedDateLabel.text = book.publishedDate.convert()
        
        
        return cell
    }
}

