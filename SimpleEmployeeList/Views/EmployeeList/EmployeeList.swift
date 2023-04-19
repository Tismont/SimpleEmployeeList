//
//  EmployeeList.swift
//  SimpleEmployeeList
//
//  Created by Vojtěch Šimek on 19.04.2023.
//

import SwiftUI

struct EmployeeList: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Employee.createdDate, ascending: false)]) var employeeList: FetchedResults<Employee>
    @Environment(\.managedObjectContext) var moc

    @State private var name = ""
    @State private var position = ""
    @State private var searchInput = ""
    @State private var toastMessageVisible = false
    @State private var toastMessageText = ""
    
    var searchResults: [Employee] {
        return employeeList.filter { $0.name!.localizedStandardContains(searchInput) }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        VStack {
                            TextField("Search by a name...", text: $searchInput)
                                .padding(.bottom, 36)

                            TextField("Name", text: $name)
                                .padding(.horizontal, 24)
                            TextField("Position", text: $position)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 4)
                            Button() {
                                saveEmployee()
                            } label: {
                                Text("Save")
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.vertical, 4)
                        }
                        Spacer()
                    }
                    
                    VStack {
                        ForEach(searchInput.isEmpty ? Array(employeeList) : searchResults, id: \.self) { employee in
                            NavigationLink(destination: EmployeeDetail(name: employee.name ?? "", position: employee.position ?? "", id: employee.id!)) {
                                HStack {
                                    Text(employee.name ?? "")
                                    Spacer()
                                    
                                    Button() {
                                        withAnimation(.linear(duration: 0.15)) {
                                            if let thisEmployee = employeeList.first(where: {$0.id == employee.id}) {
                                                moc.delete(thisEmployee)
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
                                    } label: {
                                        Text("delete")
                                    }
                                    .padding(.leading, 8)
                                    
                                    Image(systemName: "arrow.right")
                                        .padding(.leading, 8)
                                }
                                .padding(.horizontal, 4)
                            }
                            Divider()
                            .padding(.vertical, 2)
                        }
                    }
                    .padding(.top, 26)
                    .padding(.bottom, 12)
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 8)
            
            if toastMessageVisible {
                ToastMessage(toastMessageText: toastMessageText)
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .textFieldStyle(.roundedBorder)
    }
    
    func getDate() -> Int {
        let someDate = Date()
        let timeInterval = someDate.timeIntervalSince1970
        let myInt = Int(timeInterval)
        return myInt
    }
    
    func saveEmployee() {
        withAnimation(.linear(duration: 0.15)) {
            if !name.isEmpty && !position.isEmpty {
                let employee = Employee(context: moc)
                employee.name = name
                employee.position = position
                employee.id = UUID()
                employee.createdDate = Int64(getDate())
                do {
                    try moc.save()
                    name = ""
                    position = ""
                } catch {
                    withAnimation {
                        toastMessageText = "An error ocurred while saving an employee."
                        toastMessageVisible = true
                        withAnimation(.default.delay(1.2)) {
                            toastMessageVisible = false
                        }
                    }
                }
            }
        }
    }
}
struct EmployeeList_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeList()
    }
}
