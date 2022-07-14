//
//  ToDo_List_SwiftUIApp.swift
//  ToDo_List_SwiftUI
//
//  Created by Diego Carvalho on 14/07/22.
//

import SwiftUI

@main
struct ToDo_List_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
