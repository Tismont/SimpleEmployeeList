//
//  DataController.swift
//  SimpleEmployeeList
//
//  Created by Vojtěch Šimek on 19.04.2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "SimpleEmployeeList")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}


