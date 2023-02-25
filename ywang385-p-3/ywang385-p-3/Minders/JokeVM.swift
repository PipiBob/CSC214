//
//  JokeVM.swift
//  Minders
//
//  Created by Wang, Yun on 12/9/22.
//

import Foundation
class JokeVM: ObservableObject {
    
    @Published var jokes: [Joke]
    
    init(jokes: [Joke]) {
        self.jokes = jokes
    }

    // MARK: - Utilty
    func add(createdAt: String, iconUrl: String, id: String ,updatedAt: String, value: String, url: String, type: String, alert: Date) {
        jokes.insert(Joke(createdAt: createdAt, iconUrl: iconUrl, id: id, updatedAt :updatedAt , value: value, url: url, type: type, alert: alert), at: 0)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        jokes.move(fromOffsets: source, toOffset: destination)
    }

    func remove(offsets: IndexSet) {
        jokes.remove(atOffsets: offsets)
    }

}
