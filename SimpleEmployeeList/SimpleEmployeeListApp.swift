//
//  SimpleEmployeeListApp.swift
//  SimpleEmployeeList
//
//  Created by Vojtěch Šimek on 19.04.2023.
//

import SwiftUI

@main
struct SimpleEmployeeListApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
