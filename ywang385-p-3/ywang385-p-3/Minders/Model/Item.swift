//
//  Item.swift
//  Minders
//
//  Created by Arthur Roolfs on 11/14/22.
//

import Foundation

struct Item: Identifiable, Equatable, Codable {
    var title: String
    var id = UUID()
    var date = Date()
    
    var notes: String?
    var alert: Date?
    var notify: Bool?
}
