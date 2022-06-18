//
//  MyBudgetApp.swift
//  MyBudget
//
//  Created by Ilya Cherkasov on 18.06.2022.
//

import SwiftUI

@main
struct MyBudgetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
