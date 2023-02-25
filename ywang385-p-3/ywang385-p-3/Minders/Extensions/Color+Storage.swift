//
//  Color+Storage.swift
//  Minders
//
//  Created by Arthur Roolfs on 11/22/22.
//

import Foundation
import SwiftUI

extension Color: RawRepresentable {
    
    public init?(rawValue: String) {
        guard let data = Data(base64Encoded: rawValue) else {
            self = .black
            return
        }
        
        do {
            let uiColor = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .black
            self = Color(uiColor)
        } catch { self = .black }
    }

    public var rawValue: String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
        } catch { return error.localizedDescription }
    }
}
