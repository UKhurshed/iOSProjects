//
//  DataManager.swift
//  info_systems_problem
//
//  Created by Khurshed Umarov on 01.11.2021.
//

import Foundation

public class DataManager{
    
    static fileprivate func getDocumentDirectory() -> URL{
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            return url
        }else{
            fatalError("Cannot open document")
        }
    }
    
    static func save<T: Encodable>(_ object: T, with fileName: String){
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path){
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        }catch{
            fatalError(error.localizedDescription)
        }
    }
    
    static func load<T: Decodable>(_ fileName: String, with type: T.Type) -> T{
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path){
            fatalError("File not found \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path){
            do{
                let model = try JSONDecoder().decode(type, from: data)
                return model
            }catch{
                fatalError(error.localizedDescription)
            }
        }else{
            fatalError("Data unavailable at path: \(url.path)")
        }
    }
    
    static func load(_ fileName: String) -> Data?{
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path){
            fatalError("File not found \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path){
            return data
        }else{
            fatalError("Data unavailable at path: \(url.path)")
        }
    }
    
    static func loadAll<T: Decodable>(_ type: T.Type) -> [T]{
        do{
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            var modelObjects = [T]()
            for fileName in files{
                modelObjects.append(load(fileName, with: type))
            }
            return modelObjects
        }catch{
            fatalError("could not lead any files")
        }
    }
    
    static func delete(_ fileName: String){
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path){
            do {
                try FileManager.default.removeItem(at: url)
            }catch{
                fatalError(error.localizedDescription)
            }
        }
    }
}
