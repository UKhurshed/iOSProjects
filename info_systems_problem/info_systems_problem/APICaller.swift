//
//  APICaller.swift
//  info_systems_problem
//
//  Created by Khurshed Umarov on 26.10.2021.
//

import Foundation
import UIKit

final class APICaller{
    static let shared = APICaller()
    
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    struct Contracts{
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=ru&apiKey=fc9c93a0395d4d82ac5d3c736f184179&category=health")
    }
    
    private init(){}
    
    public func getTopStories(completion: @escaping (Result<[Articles], Error>) -> Void){
        guard let url = Contracts.topHeadlinesURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, _, error in
            if let error = error{
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

//Models

struct APIResponse: Codable{
    let articles: [Articles]
}

struct Articles: Codable{
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable{
    let name: String
}
