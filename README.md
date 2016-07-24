# Nifty Cloud Sampler

# 概要
Swift2、Xcode7.3.1で作った、Nifty Cloud mobile backendのサンプラーです。

# データベース設計

#モデルの作成方法

## モデルクラスの書き方
モデルクラスにおけるカラムの設定は、getter setterを使用します。
また```@objc```の設定、```override init!(className: String!)```、```ncmbClassName```は必須です。

```
import Foundation
import NCMB // Nifty Cloud mobile backendをインポート

@objc(Books)
class Books: NCMBObject, NCMBSubclassing {

    // それぞれのカラムを指定
    var title: String! {
        get {
            return objectForKey("title") as! String
        }
        set {
            setObject(newValue, forKey: "title")
        }
    }

    var publishedDate: NSDate {
        get {
            return objectForKey("publishedDate") as! NSDate
        }
        set {
            setObject(newValue, forKey: "publishedDate")
        }
    }

    var isPublic: Int {
        get {
            return objectForKey("isPublic") as! Int
        }
        set {
            setObject(newValue, forKey: "isPublic")
        }
    }

    var user: NCMBUser {
        get {
            return objectForKey("user") as! NCMBUser
        }
        set {
            setObject(newValue, forKey: "user")
        }
    }

    var auther: Authers {
        get {
            return objectForKey("auther") as! Authers
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
    static func create(title: String, date: NSDate, isPublic: Int, user: NCMBUser, auther: Authers) -> Books{
        // インスタンスを作成
        let book = Books(className: "Books")
        // それぞれのプロパティに適切なデータを入れる
        book.auther = auther
        book.isPublic = isPublic
        book.title = title
        book.user = user
        book.publishedDate = date
        return book
    }
    // データを更新するためのメソッド
    static func update(object: Books, user: NCMBUser, title: String, date: NSDate, isPublic: Int, auther: Authers) -> Books{
        if object.user == user {
            object.title = title
            object.auther = auther
            object.isPublic = isPublic
            object.publishedDate = date
        }
        return object
    }

    // Booksテーブルからすべてを取得
    static func loadAll(callback: (objects: [Books]) -> Void) {
        // NCMBQueryをクエリとして作成
        let query = NCMBQuery(className: "Books")
        // クエリに従ってすべてを取得
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil { // エラーがあるとき
                print(error.localizedDescription)
            }else { // エラーがないとき
                // 取得したデータをBooksクラスに変換
                let obj = objects as! [Books]
                print(obj)
                // 引数で受け取った処理を行う
                callback(objects: obj)
            }
        }
    }

    // データを非同期で通信状況に合わせて送信する
    func saveWithEvent(callback: () -> Void) {
        self.saveEventually { (error) in
            if error != nil { // エラーがあるとき
                print(error.localizedDescription)
            }else { // エラーがないとき
                // 引数で受け取った書影を行う
                callback()
            }
        }
    }

    // 必須。
    static func ncmbClassName() -> String! {
        return "Books"
    }
}
```

## AppDelegateへのモデルクラスの登録
AppDelegate.swiftにおいて、以下のメソッド内でregisterSubclassを行うことで、モデルクラスを登録します
```
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch
    Books.registerSubclass() //ModelClass.registerSubclass()でモデルクラスを登録
    Authers.registerSubclass()
    NCMB.setApplicationKey("アプリケーションキー", clientKey: "クライアントキー")
    return true
}
```
