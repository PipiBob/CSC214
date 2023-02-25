//
//  FileManager+Joke.swift
//  Minders
//
//  Created by Wang, Yun on 12/9/22.
//

import Foundation

let fileName = "MindersFile.json"

extension FileManager {
    
    func getItems() -> [Joke] {
        if let url = urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName, isDirectory: false) {
            if let jsondata = contents(atPath: url.path) {
                
                let decoder = JSONDecoder()
                do {
                    let items = try decoder.decode([Joke].self, from: jsondata)
                    return items
                } catch { fatalError(error.localizedDescription) }
            }
        }
        
        return [Joke]()
    }
    
    func saveItems(jokes: [Joke]) {
        if let url = urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName, isDirectory: false) {
            if fileExists(atPath: url.path) {
                do {
                    try removeItem(at: url)
                } catch { fatalError(error.localizedDescription) }
            }
            
            if let encodedData = try? JSONEncoder().encode(jokes) {
                createFile(atPath: url.path, contents: encodedData, attributes: nil)
            } else {
                fatalError("Couldn't write data!")
            }
        }
    }
}
