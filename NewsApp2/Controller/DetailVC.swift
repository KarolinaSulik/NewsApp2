//
//  DetailVC.swift
//  NewsApp2
//
//  Created by Karolina Sulik on 09.06.22.
//

import UIKit

class DetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        
    }

    init(article: Article) {
        super.init(nibName: nil, bundle: nil)
        print(article.title)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
