//
//  Register.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 04/09/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct Register: View {
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var lastname: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage = ""
    
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Colors.lightGreen
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Image("Logo_App")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                            .clipShape(Circle())
                            .shadow(radius: 10)
                        Text("OCOYUCAN LENS")
                            .font(TextStyles.logo_title)
                            .foregroundColor(Colors.mainGreen)
                    }
                    Spacer()
                    
                    // Campos de entrada para email, name, lastname, password y confirmPassword con validación
                    InputView(
                        text: $email,
                        placeholder: "Ingrese su e-mail",
                        icon: "envelope.fill",
                        title: "Correo electrónico",
                        isValid: isValidEmail
                    )
                    InputView(
                        text: $name,
                        placeholder: "Ingrese su nombre",
                        icon: "person.fill",
                        title: "Nombre"
                    )
                    InputView(
                        text: $lastname,
                        placeholder: "Ingrese su apellido",
                        icon: "keyboard.fill",
                        title: "Apellido"
                    )
                    InputView(
                        text: $password,
                        placeholder: "Ingrese su contraseña",
                        icon: "lock.fill",
                        title: "Contraseña",
                        isSecureField: true,
                        isValid: isValidPassword // Validación de contraseña
                    )
                    InputView(
                        text: $confirmPassword,
                        placeholder: "Confirme su contraseña",
                        icon: "lock.fill",
                        title: "Confirmar Contraseña",
                        isSecureField: true,
                        isValid: { $0 == password } // Validación para confirmar contraseña
                    )
                    
                    Spacer()
                    
                    // Mensaje de error si algo está mal
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                    
                    // Botón de registro con validación completa
                    Button(action: {
                        if password != confirmPassword {
                            errorMessage = "Las contraseñas no coinciden. Inténtalo de nuevo."
                        } else if !isValidPassword(password) {
                            errorMessage = "La contraseña debe tener al menos 6 caracteres, una mayúscula y un carácter especial."
                        } else if !isValidEmail(email) {
                            errorMessage = "Por favor, ingresa un correo electrónico válido."
                        } else {
                            // Llamar al método de registro si todas las validaciones son exitosas
                            viewModel.registerUser(email: email, password: password, name: name, lastname: lastname)
                            errorMessage = ""
                        }
                    }) {
                        HStack {
                            Text("Registrar")
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

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register(viewModel: UserViewModel())
    }
}









    

