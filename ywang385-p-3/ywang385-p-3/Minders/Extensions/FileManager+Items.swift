//
//  FileManager+Items.swift
//  Minders
//
//  Created by Arthur Roolfs on 11/14/22.
//
/*
import Foundation

let fileName = "MindersFile.json"

extension FileManager {
    
    func getItems() -> [Item] {
        if let url = urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName, isDirectory: false) {
            if let jsondata = contents(atPath: url.path) {
                
                let decoder = JSONDecoder()
                do {
                    let items = try decoder.decode([Item].self, from: jsondata)
                    return items
                } catch { fatalError(error.localizedDescription) }
            }
        }
        
        return [Item]()
    }
    
    func saveItems(items: [Item]) {
        if let url = urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName, isDirectory: false) {
            if fileExists(atPath: url.path) {
                do {
                    try removeItem(at: url)
                } catch { fatalError(error.localizedDescription) }
            }
            
            if let encodedData = try? JSONEncoder().encode(items) {
                createFile(atPath: url.path, contents: encodedData, attributes: nil)
            } else {
                fatalError("Couldn't write data!")
            }
        }
    }
}*/
