//
//  element.swift
//  Minders
//
//  Created by Wang, Yun on 12/9/22.
//


import Foundation//joke open api
class element: Decodable {
    enum CodingKeys: String, CodingKey {
        case created_at
        case icon_url
        case id
        case updated_at
        case value
        case url}
    
    var created_at : String?
    var icon_url : String?
    var id: String?
    var updated_at : String?
    var value : String?
    var url : String?
    
    init() {
        created_at = ""
        icon_url = ""
        id = ""
        updated_at = ""
        value = ""
        url = ""}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        created_at = try container.decode(String.self, forKey: .created_at)
        icon_url = try container.decode(String.self, forKey: .icon_url)
        id = try container.decode(String.self, forKey: .id)
        updated_at = try container.decode(String.self, forKey: .updated_at)
        value = try container.decode(String.self, forKey: .value)
        url = try container.decode(String.self, forKey: .url)}}
