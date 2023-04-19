//
//  ToastMessage.swift
//  SimpleEmployeeList
//
//  Created by Vojtěch Šimek on 19.04.2023.
//

import SwiftUI

struct ToastMessage: View {
    var toastMessageText: String
    var body: some View {
        HStack {
            HStack {
                Text(toastMessageText)
                    .padding(14)
                    .background(Color("ToastMessageBackground"))
                    .cornerRadius(14)
                    .font(.system(size: 16))
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .multilineTextAlignment(.center)
        .zIndex(1)
        .padding(.horizontal, 26)
    }
}

struct ToastMessage_Previews: PreviewProvider {
    static var previews: some View {
        ToastMessage(toastMessageText: "Something went wrong.")
    }
}
