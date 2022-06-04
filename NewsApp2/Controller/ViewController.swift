//
//  ViewController.swift
//  NewsApp2
//
//  Created by Karolina Sulik on 31.05.22.
//

import UIKit

class ViewController: UIViewController {

    //Enums sind standardmäßig zum Hashable Protocols konform.
    enum Section /* :Hashable*/ {
        case main
        
    }
    
    
    private let tableView = UITableView()
    var dataSource: UITableViewDiffableDataSource<Section, Article>!
    
    private var data: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        configureDataSource()
        
        
        NetworkManager.shared.getNewsItems { (result) in
            switch result {
            case .success(let newsResponse):
               
                self.updateData(articles: newsResponse.articles)
//                response.articles.forEach { (article) in
//                    print(article.title ?? "N/A")
//                }
                
            case.failure(let error):
                print(error.rawValue)
            }
        }
    }
        
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pinToEdges(of: view)
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
    }
    
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Article>(tableView: tableView, cellProvider: { (tableView, indexPath, article) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as? NewsTableViewCell
            
            cell?.setCell(article: article)
            
            return cell
        })
    }
    
    func updateData(articles: [Article]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.main])
        snapshot.appendItems(articles)
        self.dataSource.apply(snapshot)
    }
    
}

//extension ViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath)
//        as? NewsTableViewCell
//        cell?.setCell(article: data[indexPath.row])
//
//
//        return cell ?? UITableViewCell()
//    }
//
//
//}
