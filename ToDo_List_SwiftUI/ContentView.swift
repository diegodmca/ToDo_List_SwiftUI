//
//  ContentView.swift
//  ToDo_List_SwiftUI
//
//  Created by Diego Carvalho on 14/07/22.
//

import SwiftUI

struct ContentView: View {
    @FocusState var isFocused: Bool
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: ToDoListItem.getAllToDoListItems())
    var items: FetchedResults<ToDoListItem>
    @State var text: String = ""
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("New Item")) {
                    HStack {
                        TextField("Enter new item...", text: $text)
                            .keyboardType(.default)
                            .focused($isFocused)
                        Button(action: {
                            
                            if !text.isEmpty{
                                let newItem = ToDoListItem(context: context)
                                newItem.name = text
                                newItem.createdAt = Date()
                                do {
                                    try context.save()
                                }
                                catch {
                                    print(error)
                                }
                                text = ""
                            }
                        }, label: {
                            Text("Save")
                        })
                    }
                }
                Section{
                    ForEach(items) { toDoListItem in
                        VStack(alignment: .leading){
                            Text(toDoListItem.name!)
                                .font(.headline)
                            Text("\(toDoListItem.createdAt!.formatted(date: .abbreviated, time: .shortened))")
                        }
                    }.onDelete(perform: { indexSet in
                        guard let index = indexSet.first else {
                            return
                        }
                        let itemToDelete = items[index]
                        context.delete(itemToDelete)
                        do{
                            try context.save()
                        }
                        catch {
                            print(error)
                        }
                    })
                    
                }
            }
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
        
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
