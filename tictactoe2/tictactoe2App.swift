//
//  tictactoe2App.swift
//  tictactoe2
//
//  Created by Paul Pacheco on 23/05/23.
//

import SwiftUI

@main
struct tictactoe2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
