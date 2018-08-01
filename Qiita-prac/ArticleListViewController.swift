//
//  ArticleListViewController.swift
//  Qiita-prac
//
//  Created by 佐藤賢 on 2018/08/01.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import Alamofire

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
        print(response.result.value)
    }
  }
  
}
