//
//  ContentView.swift
//  SecureField
//
//  Created by 名前なし on 2022/07/22.
//

import SwiftUI

struct ContentView: View {

    @State var password: String = ""
    @State var isPasswordMasking: Bool = false
    var body: some View {

        SecureSwitchField(
            label: "パスワード",
            value: $password,
            masking: $isPasswordMasking
        )
        .frame(width: 300, height: 50)
    }
}

struct SecureSwitchField: View {

    let label: String
    @Binding var value: String
    @Binding var masking: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .trailing) {
                SecureField(label, text: $value)
                    .padding(.leading, geometry.size.width * 0.03)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(.white)
                    .border(.gray)

                TextField(label, text: $value)
                    .padding(.leading, geometry.size.width * 0.03)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(.white)
                    .border(.gray)
                    .opacity(masking ? 0 : 1)

                Image(systemName: masking ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.black)
                    .background(.white)
                    .padding(.trailing, geometry.size.width * 0.03)
                    .onTapGesture {
                        masking.toggle()
                    }
            }
        }
    }

    struct SolidTextField: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(.leading, 10)
                .frame(width: 290, height: 41)
                .background(.white)
                .border(.gray)
        }
    }
}


extension View {
    func solidTextField() -> some View {
        self.modifier(SecureSwitchField.SolidTextField())
    }
}
