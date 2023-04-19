//
//  EmployeeDetail.swift
//  SimpleEmployeeList
//
//  Created by Vojtěch Šimek on 19.04.2023.
//

import SwiftUI

struct EmployeeDetail: View {
    @FetchRequest(sortDescriptors: []) var employeeList: FetchedResults<Employee>
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    var name: String
    var position: String
    var id: UUID
    
    @State private var toastMessageVisible = false
    @State private var toastMessageText = ""
    
    var body: some View {
        ZStack {
            VStack {
                Text(name)
                    .font(.system(size: 22))
                    .multilineTextAlignment(.center)
                Text(position)
                    .font(.system(size: 18))
                    .padding(.top, 8)
                    .multilineTextAlignment(.center)
            }
            if toastMessageVisible {
                ToastMessage(toastMessageText: toastMessageText)
            }
        }
        .padding(.horizontal, 8)
        .toolbar {
            Button() {
                deleteEmployee()
            } label: {
                Image(systemName: "trash")
            }
        }
    }
    func deleteEmployee() {
        if let employeeDelete = employeeList.first(where: {$0.id == id}) {
            moc.delete(employeeDelete)
            dismiss()
            do {
                try moc.save()
            } catch {
                withAnimation {
                    toastMessageText = "An error ocurred while deleting an employee."
                    toastMessageVisible = true
                    withAnimation(.default.delay(1.2)) {
                        toastMessageVisible = false
                    }
                }
            }
        }
    }
}

struct EmployeeDetail_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeDetail(name: "Keith Richards", position: "Mobile app developer", id: UUID())
    }
}
