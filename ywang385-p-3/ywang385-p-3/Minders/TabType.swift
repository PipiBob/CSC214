//
//  TabType.swift
//  Minders
//
//  Created by Arthur Roolfs on 11/22/22.
//

import Foundation
import SwiftUI

enum TabType: Int, CaseIterable {
    case list, settings, info, Content1
    
    func title() -> String {
        switch self {
        case .list:
            return "list".capitalized
        case .settings:
            return "settings".capitalized
        case .info:
            return "info".capitalized
        case .Content1:
            return "generator".capitalized
        }
    }
    
    func image() -> String {
        switch self {
        case .list:
            return "list.bullet.rectangle.fill"
        case .settings:
            return "gearshape.fill"
        case .info:
            return "info"
        case .Content1:
            return "person"
        }
    }
}
