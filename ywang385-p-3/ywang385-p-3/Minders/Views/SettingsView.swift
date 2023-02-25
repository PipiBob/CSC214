//
//  SettingsView.swift
//  Minders
//
//  Created by Arthur Roolfs on 11/22/22.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("colorScheme") var colorScheme = 0
    @AppStorage("largeFont") var largeFont = false
    @AppStorage("inlineNotes") var inlineNotes = false
    @AppStorage("textColor") var textColor: Color = Color.black
    @AppStorage("isHoliday") var isHoliday = false
    
    var body: some View {
            Form {
                Section("Appearance") {
                    Picker(selection: $colorScheme, label: Text("Appearance")) {
                        Text("System").tag(0)
                        Text("Light").tag(1)
                        Text("Dark").tag(2)
                    }
                    .pickerStyle(.segmented)
                }
                Section("Text") {
                    ColorPicker("Color", selection: $textColor)
                }
                Section("Font") {
                    Toggle("Large", isOn: $largeFont)
                }
                Section("Notes") {
                    Toggle("In List", isOn: $inlineNotes)
                }
                Section("Christmas"){
                    Toggle("Change scheme", isOn: $isHoliday)
                }
            }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
