//
//  AddItemView.swift
//  Minders
//
//  Created by Arthur Roolfs on 11/14/22.
//

import SwiftUI

struct AddItemView: View {
    
    @EnvironmentObject var itemsVM: ItemsVM
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var notificationMgr = NotificationMgr()
    
    @State private var title = ""
    @State private var notes = ""
    @State private var notify = false
    @State private var alert = Date()
    @State private var shouldAlert = false
    
    var body: some View {
        
        NavigationView {
            Form {
                Section("Must remember:") {
                    TextEditor(text: $title)
                        .font(.body)
                }
                Section("Notes") {
                    TextEditor(text: $notes)
                        .font(.body)
                }
                Section("Date") {
                    DatePicker("When:", selection: $alert)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    HStack {
                        Toggle("Set Alert:", isOn: $shouldAlert)
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            itemsVM.add(title: title, alert: alert, notes: notes, notify: shouldAlert)
                            if shouldAlert {
                                notificationMgr.scheduleNotification(title: title, notes: notes, date: alert)
                            }
                            dismiss()
                        }, label: {
                            Text("Save")
                        })
                        .disabled(title.isEmpty)
                        Spacer()
                    }
                }
            }
            .navigationTitle("New Minder")
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
