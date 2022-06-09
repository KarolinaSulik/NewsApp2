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
    
    private var articles: [Article] = []
    
    private var containerView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        configureDataSource()
        updateNewsItems()
        configureRefreshControl()
        
    }
    
    private func configureRefreshControl(){
        let refresh = UIRefreshControl()
        tableView.refreshControl = refresh
        tableView.refreshControl?.addTarget(self, action: #selector(updateNewsItems), for: .valueChanged)
    }
    
    
    @objc
    func updateNewsItems() {
        DispatchQueue.main.async {
            //print("TEST 3 \(Thread.isMainThread)")
            self.tableView.refreshControl?.endRefreshing()
        }
        
        showLoadingSpinner()
        NetworkManager.shared.getNewsItems { (result) in
            switch result {
            case .success(let newsResponse):
                self.articles = newsResponse.articles
                self.updateData(articles: newsResponse.articles)
            case.failure(let error):
                self.presentWarningAlert(title: "Fehler", message: error.rawValue)
            }
            self.dismissLoadingSpinnner()
        }
    }
        
    
    private func configureVC(){
        view.backgroundColor = .systemBackground
        title = "Nachrichten"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pinToEdges(of: view)
        tableView.delegate = self
        
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
    
    func showLoadingSpinner() {
        var newContainerView = UIView()
        view.addSubview(newContainerView)
        newContainerView.translatesAutoresizingMaskIntoConstraints = false
        newContainerView.pinToEdges(of: view)
        newContainerView.backgroundColor = .systemBackground
        newContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            newContainerView.alpha = 0.85
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        newContainerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: newContainerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: newContainerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
        
        containerView = newContainerView
    }
    
    func dismissLoadingSpinnner(){
        DispatchQueue.main.async {
            self.containerView?.removeFromSuperview()
            print(self.containerView?.subviews)
            self.containerView = nil
        }
    }
    
}


extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let selectedArticle = dataSource.itemIdentifier(for: indexPath) {
            let detailVC = DetailVC(article: selectedArticle)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
