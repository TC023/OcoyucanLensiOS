//
//  MyPorfile.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 26/09/24.
//

import SwiftUI

struct MyProfile: View {
    @StateObject private var viewModel = UserViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAch_Rutas = true
    @State private var showAch_Flora = true

    var body: some View {
        NavigationView {
            ZStack {
                Color(Colors.mainGreen)
                    .ignoresSafeArea()
                
                VStack {

                    Text("Mi perfil")
                        .font(TextStyles.title)
                        .foregroundColor(Colors.lightGreen)
                    
                    if let user = viewModel.user { // Si los datos del usuario están cargados
                        HStack {
                            Text(user.name.prefix(1) + user.lastname.prefix(1))
                                .font(TextStyles.title)
                                .frame(width: 50, height: 50)
                                .foregroundColor(Colors.lightGreen)
                                .background(Color(Colors.mainGreen))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 1) {
                                Text(user.name + " " + user.lastname)
                                    .font(TextStyles.title)
                                    .foregroundColor(Colors.mainGreen)
                                Text(user.email)
                                    .font(TextStyles.body)
                                    .foregroundColor(Colors.mainGreen)
                            }
                        }
                        .frame(width: 350, height: 85)
                        .roundedBorder()
                        
                        Spacer()
                        
                        // Información adicional del usuario
                        SettingsRowView(imageName: "star.circle.fill", title: "250", description: "Puntos totales")
                        SettingsRowView(imageName: "trophy.fill", title: "2", description: "Insignias recolectadas")
                        
                        NavigationLink(destination: Achievements_flora()) {
                            VStack(spacing: 5) {
                                Text("Nivel de flora")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .offset(x: 55)
                                    .font(TextStyles.body)
                                    .foregroundColor(Colors.lightGreen)
                                HStack {
                                    Image(systemName: "medal.fill")
                                        .font(TextStyles.body)
                                        .foregroundColor(Colors.mainGreen)
                                    Text("Bronce")
                                        .font(TextStyles.body)
                                        .foregroundColor(Colors.mainGreen)
                                }
                                .padding(.horizontal, 50)
                                .frame(width: 320, height: 60)
                                .roundedBorder()
                            }
                        }
                    
                        NavigationLink(destination: Achievements_rutas()){
                            VStack(spacing: 5) {
                                Text("Nivel de rutas")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .offset(x: 55)
                                    .font(TextStyles.body)
                                    .foregroundColor(Colors.lightGreen)
                                HStack {
                                    Image(systemName: "medal.fill")
                                        .font(TextStyles.body)
                                        .foregroundColor(Colors.mainGreen)
                                    Text("Bronce")
                                        .font(TextStyles.body)
                                        .foregroundColor(Colors.mainGreen)
                                }
                                .padding(.horizontal, 50)
                                .frame(width: 320, height: 60)
                                .roundedBorder()
                            }
                        }
                    } else {
                        Text("Cargando datos...")
                            .font(TextStyles.body)
                            .foregroundColor(Colors.lightGreen)
                    }
                    
                    Spacer()
                    
                    // Botón de cerrar sesión
                    Button(action: {
                        viewModel.signOut()
                    }) {
                        Text("Cerrar sesión")
                            .font(TextStyles.body)
                            .frame(width: 240, height: 35)
                            .foregroundColor(Colors.lightGreen)
                            .roundedBorder(borderColor: Colors.lightGreen, backgroundColor: Colors.mainGreen)
                            .padding(.vertical, 5)
                    }
                    
                    // Botón de navegación a la vista de edición del perfil
                    NavigationLink(destination: EditProfileView(user: viewModel.user, viewModel: viewModel)) {
                        Text("Editar perfil")
                            .font(TextStyles.body)
                            .frame(width: 240, height: 35)
                            .foregroundColor(Colors.lightGreen)
                            .roundedBorder(borderColor: Colors.lightGreen, backgroundColor: Colors.mainGreen)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            CustomButton(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, color:Colors.lightGreen )
                            
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct MyProfile_Previews: PreviewProvider {
    static var previews: some View {
        MyProfile()
    }
}



  




