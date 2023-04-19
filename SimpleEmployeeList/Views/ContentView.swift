//
//  ContentView.swift
//  SimpleEmployeeList
//
//  Created by Vojtěch Šimek on 19.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                EmployeeList()
                    .tabItem {
                        Label("Employee List", systemImage: "person")
                    }
                
                About()
                    .tabItem {
                        Label("About", systemImage: "questionmark.circle")
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
