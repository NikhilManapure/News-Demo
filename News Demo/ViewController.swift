//
//  ViewController.swift
//  News Demo
//
//  Created by Evolusolve on 12/01/19.
//  Copyright © 2019 Evolusolve. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!

    var news: [News] = []
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        getNews(page: currentPage) { newArticles in
            self.news = newArticles
            self.newsTableView.reloadData()
        }
    }
}

extension ViewController {
    func configureTableView() {
        newsTableView.register(NewsCell.self)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        newsTableView.refreshControl = refreshControl
        newsTableView.rowHeight = UITableViewAutomaticDimension
        newsTableView.estimatedRowHeight = 100
        newsTableView.contentInset = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0)
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        getNews(page: currentPage) { newArticles in
            self.news = newArticles
            self.newsTableView.reloadData()
            sender.endRefreshing()
            self.currentPage = 0
        }
    }
    
    func getNews(page: Int, size: Int = 5, completion: @escaping ([News])->()) {
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=a8fabd9ff4234c82aad08eaaa4ea17a0&pageSize=\(size)&page=\(page)").responseJSON { (responseData) -> Void in
            if let value = responseData.result.value as? [String: Any],
                let articles = value["articles"] as? [[String: Any]]  {
                var newArticles: [News] = []
                articles.forEach({ (rawArticle) in
                    if let article = News(raw: rawArticle) {
                        newArticles.append(article)
                    }
                })
                completion(newArticles)
            }
        }
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell = tableView.dequeueReusableCell(for: indexPath)
        cell.news = news[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == news.count - 1 {
            getNews(page: currentPage + 1, completion: { (newArticles) in
                self.news.append(contentsOf: newArticles)
                self.currentPage = self.currentPage + 1
                self.newsTableView.reloadData()
            })
        }
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
