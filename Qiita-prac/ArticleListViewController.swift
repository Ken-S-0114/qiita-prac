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
  
  // 記事を入れるプロパティを定義
  var articles: [[String: String?]] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getArticles()

  }
  
  private func getArticles(){
    // APIへリクエストを送信
    Alamofire.request("https://qiita.com/api/v2/items", method: .get)
      // responseJSONメソッドは1つの関数を引数(Response<AnyObject, NSError>型 )に取る
      .responseJSON { response in
        guard let object = response.result.value else { return }
        // AnyObject型からJSON型に変換
        let json = JSON(object)
        // タプル型の引数にはその要素が何番目かと記事1つのデータの2つの要素が入る
        json.forEach { (_, json) in
          let article: [String: String?] = [
            "title": json["title"].string,
            "userId": json["user"]["id"].string
          ]
          self.articles.append(article)
        }
        self.articleTableView.reloadData()
    }
  }
  
}

extension ArticleListViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
    let article = articles[indexPath.row]
    cell.textLabel?.text = article["title"]!
    cell.detailTextLabel?.text = article["userId"]!
    return cell
  }
}
