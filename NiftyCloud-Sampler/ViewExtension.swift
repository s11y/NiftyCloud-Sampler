//
//  ViewExtension.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/07/03.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bookCell") as! BookCell
        
        let book = books[indexPath.row]
        print(book.title)
        cell.titleLabel.text = book.title
        cell.publishedDateLabel.text = book.publishedDate.convert()
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Default, title: "Delete") { (action, index) in
            self.deleteObject(index)
        }
        
        let edit = UITableViewRowAction(style: .Default, title: "Edit") { (action, index) in
            self.updateBook = self.books[index.row]
            self.transition()
        }
        edit.backgroundColor = UIColor.greenColor()
        return [delete, edit]
    }
}