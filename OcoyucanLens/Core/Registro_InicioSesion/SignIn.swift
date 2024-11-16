//
//  SignUp.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 04/09/24.
//

import SwiftUI
import FirebaseAuth

struct SignIn: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage = ""
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Colors.lightGreen
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    VStack{
                        Image("Logo_App")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                            .clipShape(Circle())
                            .shadow(radius: 9)
                        
                        Text("OCOYUCAN LENS")
                            .font(TextStyles.logo_title)
                            .foregroundColor(Colors.mainGreen)
                    }.padding(20)
                    
                  
                    
                    // Campos de entrada para email y password
                    VStack{
                        InputView(
                            text: $email,
                            placeholder: "Correo electrónico",
                            icon: "envelope.fill",
                            title: "Correo electrónico",
                            isValid: isValidEmail
                        )
                        
                        InputView(
                            text: $password,
                            placeholder: "Ingrese su contraseña",
                            icon: "lock.fill",
                            title: "Contraseña",
                            isSecureField: true,
                            isValid: isValidPassword
                        )
                    }
                    
                    Spacer()
                    
                    if !errorMessage.isEmpty { 
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                    
                    Button(action: {
                        if !isValidEmail(email) {
                            errorMessage = "Por favor, ingresa un correo electrónico válido."
                        } else if !isValidPassword(password) {
                            errorMessage = "La contraseña debe tener al menos 6 caracteres, una mayúscula y un carácter especial."
                        } else {
                            viewModel.signInUser(email: email, password: password)
                            errorMessage = ""
                        }
                    }) {
                        HStack {
                            Text("Iniciar sesión")
                                .font(TextStyles.body)
                                .frame(width: 320, height: 60)
                                .foregroundColor(Colors.lightGreen)
                                .roundedBorder(borderColor: Colors.mainGreen, backgroundColor: Colors.mainGreen)
                                .shadow(radius: 9)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}


struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(viewModel: UserViewModel())
    }
}





