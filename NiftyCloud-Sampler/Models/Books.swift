//
//  Books.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/30.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import Foundation
import NCMB // Nifty Cloud mobile backendをインポート

@objc(Books)
class Books: NCMBObject, NCMBSubclassing {

    // それぞれのカラムを指定
    var title: String! {
        get {
            return object(forKey: "title") as? String
        }
        set {
            setObject(newValue, forKey: "title")
        }
    }

    var publishedDate: Date {
        get {
            return object(forKey: "publishedDate") as! Date
        }
        set {
            setObject(newValue, forKey: "publishedDate")
        }
    }

    var isPublic: Int {
        get {
            return object(forKey: "isPublic") as! Int
        }
        set {
            setObject(newValue, forKey: "isPublic")
        }
    }

    var user: NCMBUser {
        get {
            return object(forKey: "user") as! NCMBUser
        }
        set {
            setObject(newValue, forKey: "user")
        }
    }

    var auther: Authers {
        get {
            return object(forKey: "auther") as! Authers
        }
        set {
            setObject(newValue, forKey: "auther")
        }
    }

    //　必須 呼び出すときに、Class Nameを指定
    override init!(className: String!) {
        super.init(className: className)
    }

    // 保存・作成するためのNCMBObject(Books)を作成するためのメソッド
    static func create(title: String, date: Date, isPublic: Int, user: NCMBUser, auther: Authers) -> Books{
        // インスタンスを作成
        let book = Books(className: "Books")
        // それぞれのプロパティに適切なデータを入れる
        book?.auther = auther
        book?.isPublic = isPublic
        book?.title = title
        book?.user = user
        book?.publishedDate = date
        return book!
    }
    // データを更新するためのメソッド
    static func update(object: Books, user: NCMBUser, title: String, date: Date, isPublic: Int, auther: Authers) -> Books{
        if object.user == user {
            object.title = title
            object.auther = auther
            object.isPublic = isPublic
            object.publishedDate = date
        }
        return object
    }

    // Booksテーブルからすべてを取得
    static func loadAll(callback: @escaping (_ objects: [Books]) -> Void) {
        // NCMBQueryをクエリとして作成
        let query = NCMBQuery(className: "Books")
        query?.includeKey = "auther"
        // クエリに従ってすべてを取得
        query?.findObjectsInBackground { (objects, error) in
            if error != nil { // エラーがあるとき
                print(error.debugDescription)
            }else { // エラーがないとき
                // 取得したデータをBooksクラスに変換
                let obj = objects as! [Books]
                print("autherとは...\(obj[0].auther)")
                print(obj)
                // 引数で受け取った処理を行う
                callback(obj)
            }
        }
    }

    // データを非同期で通信状況に合わせて送信する
    func saveWithEvent(callback: @escaping () -> Void) {
        self.saveEventually { (error) in
            if error != nil { // エラーがあるとき
                print(error.debugDescription)
            }else { // エラーがないとき
                // 引数で受け取った処理を行う
                callback()
            }
        }
    }

    // 必須。
    static func ncmbClassName() -> String! {
        return "Books"
    }
}
