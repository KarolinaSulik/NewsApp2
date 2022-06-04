//
//  ViewController.swift
//  NewsApp2
//
//  Created by Karolina Sulik on 31.05.22.
//

import UIKit

class ViewController: UIViewController {

    private let tableView = UITableView()
    private var data: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        
        NetworkManager.shared.getNewsItems { (result) in
            switch result {
            case .success(let newsResponse):
                self.data = newsResponse.articles
               // self.data = response.articles.map {$0.title ?? "N/A"}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
//                response.articles.forEach { (article) in
//                    print(article.title ?? "N/A")
//                }
                
            case.failure(let error):
                print(error.rawValue)
            }
        }
        
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.pinToEdges(of: view)
        
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
    }
    
    }

    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath)
        as? NewsTableViewCell
        cell?.setCell(article: data[indexPath.row])


        return cell ?? UITableViewCell()
    }
    
    
}
