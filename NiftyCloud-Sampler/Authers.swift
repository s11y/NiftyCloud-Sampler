//
//  Authers.swift
//  NiftyCloud-Sampler
//
//  Created by ShinokiRyosei on 2016/06/30.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import Foundation
import NCMB // Nifty Cloud mobile backendをインポート

@objc(Authers)
class Authers: NCMBObject, NCMBSubclassing {

    // それぞれのカラムを指定
    var familyName : String {
        get {
            return objectForKey("familyName") as! String
        }
        set {
            setObject(newValue, forKey: "familyName")
        }
    }

    var firstName: String {
        get {
            return objectForKey("firstName") as! String
        }set {
            setObject(newValue, forKey: "firstName")
        }
    }

    // 保存・作成するためのNCMBObject(Books)を作成するためのメソッド
    static func create(firstName: String, familyName: String) -> Authers {
        // インスタンスを作成
        let auther = Authers(className: "Authers")
        // それぞれのプロパティに適切なデータを入れる
        auther.familyName = familyName
        auther.firstName = firstName
        return auther
    }

    // データを非同期で通信状況に合わせて送信する
    func saveWithEvent(callback: () -> Void) {
        self.saveEventually { (error) in
            if error != nil { // エラーがあるとき
                print(error.localizedDescription)
            }else { // エラーがないとき
                // 引数で受け取った処理を行う
                callback()
            }
        }
    }

    // Booksテーブルからすべてを取得
    static func loadAll(callback: (objects: [Authers]) -> Void) {
        // NCMBQueryをクエリとして作成
        let query = NCMBQuery(className: "Authers")
        // クエリに従ってすべてを取得
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil { // エラーがあるとき
                print(error.localizedDescription)
            }else { // エラーがないとき
                // 取得したデータをBooksクラスに変換
                let obj = objects as! [Authers]
                print(obj)
                // 引数で受け取った処理を行う
                callback(objects: obj)
            }
        }
    }

    // データを更新するためのメソッド
    static func update(object: Authers, firstName: String, familyName: String) -> Authers {
        object.familyName = familyName
        object.firstName = firstName
        return object
    }

    //　必須 呼び出すときに、Class Nameを指定
    override init!(className: String!) {
        super.init(className: "Authers")
    }

    // 必須。
    static func ncmbClassName() -> String! {
        return "Authers"
    }
}
