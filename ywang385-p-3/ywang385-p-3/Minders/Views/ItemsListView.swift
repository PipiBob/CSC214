//
//  ItemsListView.swift
//  Minders
//
//  Created by Arthur Roolfs on 11/22/22.
//

import SwiftUI

struct ItemsListView: View {
    
    @StateObject var itemsVM: JokeVM
    @State private var addMinderPresenting = false
    
    @AppStorage("largeFont") var largeFont = false
    @AppStorage("inlineNotes") var inlineNotes = false
    @AppStorage("textColor") var textColor: Color = Color.black
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(itemsVM.jokes) { joke in
                    NavigationLink {
                        Text(joke.type ?? "")
                            .multilineTextAlignment(.leading)
                        
                    } label: {
                        HStack {
                            HStack {
                                /*Image("Bell")
                                    .resizable()
                                    .frame(width: 32, height: 32, alignment: .leading)
                                    .opacity((item.notify ?? false) ? 1 : 0)*/
                                VStack(alignment: .leading) {
                                    Text(joke.type ?? "")
                                        .font(largeFont ? .largeTitle : .headline)
                                        .fontWeight(.medium)
                                    if inlineNotes {
                                        Text(joke.alert.formatted())
                                            .font(largeFont ? .largeTitle : .headline)
                                            .fontWeight(.medium)
                                    }
                                }
                                Spacer()
                            }
                        }
                        .foregroundColor(textColor)
                    }
                }
                .onMove(perform: itemsVM.move)
                .onDelete(perform: itemsVM.remove)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addMinderPresenting = true
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $addMinderPresenting) {
                AddItemView()
            }
            .navigationTitle("Joke List")
            Text("No minders found")
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let fm = DateFormatter()
        fm.dateStyle = .short
        fm.timeStyle = .short
        fm.locale = Locale.autoupdatingCurrent
        return fm
    }()
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListView(itemsVM: JokeVM(jokes: [Joke]()))
    }
}
