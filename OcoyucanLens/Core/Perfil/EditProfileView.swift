//
//  EditProfileView.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 06/11/24.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: UserViewModel // Pasamos el ViewModel para acceder y actualizar datos
    @State private var name: String
    @State private var lastname: String
    @State private var email: String
    @State private var errorMessage = ""
    @Environment(\.presentationMode) var presentationMode // Para cerrar la vista al guardar cambios

    init(user: User?, viewModel: UserViewModel) {
        self.viewModel = viewModel
        _name = State(initialValue: user?.name ?? "")
        _lastname = State(initialValue: user?.lastname ?? "")
        _email = State(initialValue: user?.email ?? "")
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(Colors.mainGreen)
                    .ignoresSafeArea()
                VStack {
                    Text("Editar Perfil")
                        .font(TextStyles.title)
                        .foregroundColor(Colors.lightGreen)
                    
                    // Campos para editar nombre, apellido y correo
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
                        text: $email,
                        placeholder: "Ingrese su e-mail",
                        icon: "envelope.fill",
                        title: "Correo electrónico",
                        isValid: isValidEmail
                    )
                    
                    Spacer()
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                    
                    // Botón para guardar cambios
                    Button(action: saveChanges) {
                        Text("Guardar cambios")
                            .font(TextStyles.body)
                            .frame(width: 240, height: 35)
                            .foregroundColor(Colors.lightGreen)
                            .roundedBorder(borderColor: Colors.lightGreen, backgroundColor: Colors.mainGreen)
                    }
                }
                .padding()
            }
        }
    }
    
    // Función para guardar cambios
    private func saveChanges() {
        // Verificación del correo
        guard isValidEmail(email) else {
            errorMessage = "Por favor, ingresa un correo electrónico válido."
            return
        }
        
        // Crear un nuevo objeto de usuario con los cambios
        let updatedUser = User(name: name, lastname: lastname, email: email, uid: viewModel.user?.uid ?? "")
        
        // Llamar a la función de guardado en UserViewModel
        viewModel.saveUserData(updatedUser)
        
        // Cerrar la vista después de guardar los cambios
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User(name: "Juan", lastname: "Pérez", email: "juan@example.com", uid: "123"), viewModel: UserViewModel())
    }
}





