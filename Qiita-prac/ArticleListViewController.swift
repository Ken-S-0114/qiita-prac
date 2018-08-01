//
//  ArticleListViewController.swift
//  Qiita-prac
//
//  Created by 佐藤賢 on 2018/08/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ArticleListViewController: UIViewController {
  
  
  @IBOutlet weak var articleTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getArticles()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func getArticles(){
    // APIへリクエストを送信
    Alamofire.request("https://qiita.com/api/v2/items", method: .get)
      // responseJSONメソッドは1つの関数を引数(Response<AnyObject, NSError>型 )に取る
      .responseJSON { response in
        guard let object = response.result.value else { return }
        // AnyObject型からJSON型に変換
        let json = JSON(object)
        // タプル型の引数にはその要素が何番目かと記事1つのデータの2つの要素が入る
        json.forEach { (_, json) in
          // 記事タイトルを表示
          print(json["title"].string)
          // 投稿者のユーザーIDを表示
          print(json["user"]["id"].string)
        }
    }
  }
  
}
