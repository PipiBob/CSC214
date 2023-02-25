//
//  ContentView.swift
//  Minders
//
//  Created by Arthur Roolfs on 11/14/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var itemsVM: JokeVM
    @AppStorage("colorScheme") var colorScheme = 0
    
    var body: some View {
        TabView {
            Content1View()
                .tabItem {
                    Label(TabType.Content1.title(), systemImage: TabType.Content1.image())
                }
            
            ItemsListView(itemsVM: itemsVM)
                .tabItem {
                    Label(TabType.list.title(), systemImage: TabType.list.image())
                }
            SettingsView()
                .tabItem {
                    Label(TabType.settings.title(), systemImage: TabType.settings.image())
                }
            InfoView()
                .tabItem {
                    Label(TabType.info.title(), systemImage: TabType.info.image())
                }
        }
        .preferredColorScheme(colorScheme == 1 ? .light : colorScheme == 2 ? .dark : nil)
    }}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ItemsVM(items: [Item]()))
    }
}
