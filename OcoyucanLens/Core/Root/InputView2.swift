//
//  InputView2.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 07/11/24.
//

import SwiftUI

struct InputView2: View {
    @Binding var text: String
    let placeholder: String
    let icon: String
    let title: String
    var isSecureField = false
    var isValid: ((String) -> Bool)?
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 55)
                .foregroundColor(Colors.lightGreen)
                .font(TextStyles.body)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(Colors.mainGreen)
                
                if isSecureField {
                    SecureField(placeholder, text: $text)
                        .font(TextStyles.body)
                        .padding(.leading, 10)
                        .foregroundColor(Colors.mainGreen)
                } else {
                    TextField(placeholder, text: $text)
                        .font(TextStyles.body)
                        .padding(.leading, 10)
                        .foregroundColor(Colors.mainGreen)
                }
                
                // Verifica si isValid está presente y usa su resultado para mostrar el icono
                if let isValid = isValid, !text.isEmpty {
                    Image(systemName: isValid(text) ? "checkmark" : "xmark")
                        .foregroundColor(isValid(text) ? .green : .red)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal, 50)
            .frame(width: 320, height: 60)
            .roundedBorder(borderColor: Colors.lightGreen)
        }
    }
}

