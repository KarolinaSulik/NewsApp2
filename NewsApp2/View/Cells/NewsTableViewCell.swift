//
//  NewsTableViewCell.swift
//  NewsApp2
//
//  Created by Karolina Sulik on 31.05.22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let reuseID = "newsCell"
    
    
    
    private let titleLabel = NewsLabel(fontStyle: .headline)
    private let subtitleLabel = NewsLabel(fontStyle: .subheadline)
    
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        contentView.addSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        
        titleStackView.pinToEdges(of: contentView, withPadding: 15)
        
    }
    
    func setCell(article: Article) {
        self.titleLabel.text = article.title ?? "N/A"
        self.subtitleLabel.text = "\(article.publishedAt?.getStringRepresentation() ?? "N/A") Uhr"
    }
}
