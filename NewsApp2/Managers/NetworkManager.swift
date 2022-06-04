//
//  NetworkManager.swift
//  NewsApp2
//
//  Created by Karolina Sulik on 01.06.22.
//

import Foundation

enum NewsError: String, Error {
    case universalError = "Es ist ein unbekannter Fehler aufgetreten."
    case unableToComplete = "Der Request konnte nicht abgeschlossen werden. Bitte überprüfe ggf. deine Internetverbindung"
    case invalidResponse = "Ungültige Serverantwort. Versuchen Sie es später erneut."
    case invalidData = "Ungültige Daten erhalten. Versuchen Sie es später erneut."
    case invalidURL = "Es wurde eine ungültige URL verwendet."
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    private let baseURLString = "https://newsapi.org/v2/top-headlines?country=de&category=general&apiKey="
    private let apiKey = "7f11ae546f00411bb123a8ffec9a12f7"
    
    func getNewsItems(completion: @escaping (Result<NewsResponse, NewsError>) -> Void){
        let endpoint = baseURLString + apiKey
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                completion(.success(newsResponse))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
