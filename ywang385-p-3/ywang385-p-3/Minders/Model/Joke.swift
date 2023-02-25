//
//  Joke.swift
//  Minders
//
//  Created by Wang, Yun on 12/9/22.
//

import Foundation

struct Joke: Equatable, Codable,Identifiable {
    var num =  UUID()
    var createdAt : String
    var iconUrl : String
    var id: String
    var updatedAt : String
    var value : String
    var url : String
    var type : String
    var date = Date()
    var alert = Date()
}
