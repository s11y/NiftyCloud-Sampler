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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell") as! BookCell
        
        let book = books[indexPath.row]
        print(book.title)
        cell.titleLabel.text = book.title
        cell.publishedDateLabel.text = book.publishedDate.convert()
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, index) in
            self.deleteObject(indexPath: index)
            self.table.deleteRows(at: [index], with: .fade)
        }
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, index) in
            self.updateBook = self.books[index.row]
            self.toAddWithData(data: self.books[index.row])
        }
        edit.backgroundColor = UIColor.green
        return [delete, edit]
    }
}
