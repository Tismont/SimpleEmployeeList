//
//  About.swift
//  SimpleEmployeeList
//
//  Created by Vojtěch Šimek on 19.04.2023.
//

import SwiftUI

struct About: View {
    var body: some View {
        VStack {
            Text("Save, search and delete employees")
            Text("Tech stack used: Swift, SwiftUI, Core Data")
                .padding(.top, 8)
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
