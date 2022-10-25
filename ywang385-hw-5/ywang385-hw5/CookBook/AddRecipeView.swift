//
//  AddRecipeView.swift
//  MediaTracker
//
//  Created by pipiBob on 10/24/22.
//
//title// ingredient//preparation
import SwiftUI

struct AddRecipeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var ingredient = ""
    @State private var preparation = ""
    //@State private var type = FoodType.Salad
    @State private var type = ""
    
    var body: some View {
        
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)

                }
                /*
                Section("Type") {
                    Picker("Type", selection: $type) {
                        ForEach(FoodType.allCases, id: \.self) { item in
                            HStack {
                                item.image()
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32, height: 32, alignment: .center)
                                    .padding(4)
                                Text(item.title())
                            }
                        }
                    }
                }*/
                Section("Type"){
                    TextEditor(text: $type)
                }
                
                Section("Ingredient") {
                    TextEditor(text: $ingredient)
                }
                
                Section("Paration"){
                    TextEditor(text: $preparation)
                    
                }
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            addItem()
                        }, label: {
                            Text("Save")
                        })
                        .disabled(title.isEmpty || ingredient.isEmpty||preparation.isEmpty)
                        Spacer()
                    }
                }
            }
            .navigationTitle("New Item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Food(context: viewContext)
            newItem.title = title
            newItem.type = type
            newItem.preparation = preparation
            newItem.ingredient = ingredient
           

            do {
                try viewContext.save()
                dismiss()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddReceipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
            .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
    }
}
