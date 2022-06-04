//
//  Articles.swift
//  NewsApp2
//
//  Created by Karolina Sulik on 01.06.22.
//
import Foundation

// MARK: - Welcome
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Hashable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
}

// MARK: - Source
struct Source: Codable, Hashable {
    let id: String?
    let name: String?
}

