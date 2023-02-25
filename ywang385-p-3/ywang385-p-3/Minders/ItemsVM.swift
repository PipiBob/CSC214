//
//  ItemsVM.swift
//  Minders
//
//  Created by Arthur Roolfs on 11/14/22.
//

import Foundation

class ItemsVM: ObservableObject {
    
    @Published var items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }

    // MARK: - Utilty

    func add(title: String, alert: Date, notes: String, notify: Bool) {
        items.insert(Item(title: title, notes: notes, alert: alert, notify: notify), at: 0)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }

    func remove(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

}
