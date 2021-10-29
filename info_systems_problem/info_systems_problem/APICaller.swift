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
        static let topHeadlinesURL =  "https://newsapi.org/v2/top-headlines?country=ru&apiKey=fc9c93a0395d4d82ac5d3c736f184179&category="
        static let searchUrl =  "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=fc9c93a0395d4d82ac5d3c736f184179&q="
    }
    
    private init(){}
    
    public func getTopStories(with source: String, completion: @escaping (Result<[Articles], Error>) -> Void){
        guard !source.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        let urlWithSource = Contracts.topHeadlinesURL + source
        
        guard let url = URL(string: urlWithSource) else {
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
    public func getNewsByQuery(with query: String, completion: @escaping (Result<[Articles], Error>) -> Void){
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        let urlWithQuery = Contracts.searchUrl + query
        guard let url = URL(string: urlWithQuery) else {
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
