//
//  DetailView.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 12/11/24.
//
import SwiftUI

struct DetailView: View {
    var plantName: String
    var family: String
    var genus: String
    var commonNames: [String]
    var imageUrl: String
    var onDismiss: () -> Void

    var body: some View {
        VStack {
           
            HStack {
                Button(action: {
                    onDismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(TextStyles.body)
                        .foregroundColor(Colors.lightGreen)
                }
                Spacer()
            }
            .padding()

            ScrollView {
                VStack(spacing: 20) {
                    // Imagen de la planta (si está disponible)
                    if let url = URL(string: imageUrl),
                       let data = try? Data(contentsOf: url),
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .padding()
                    } else {
                        Rectangle()
                            .frame(height: 200)
                            .foregroundColor(.gray.opacity(0.2))
                            .cornerRadius(15)
                            .overlay(
                                Text("Imagen no disponible")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            )
                    }

                    // Nombre científico
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 10) {
                            Text("Nombre Científico:")
                                .foregroundStyle(Color(Colors.lightGreen))
                                .font(TextStyles.body)
                                .frame(width: 150, alignment: .leading)
                                .fontWeight(.bold)
                            Text(plantName)
                                .foregroundStyle(Color(Colors.lightGreen))
                                .font(TextStyles.body)
                        }
                        
                        // Familia
                        HStack(spacing: 10) {
                            Text("Familia:")
                                .foregroundStyle(Color(Colors.lightGreen))
                                .font(TextStyles.body)
                                .frame(width: 150, alignment: .leading)
                                .fontWeight(.bold)
                            Text(family)
                                .foregroundStyle(Color(Colors.lightGreen))
                                .font(TextStyles.body)
                        }
                        
                        // Género
                        HStack(spacing: 10) {
                            Text("Género:")
                                .foregroundStyle(Color(Colors.lightGreen))
                                .font(TextStyles.body)
                                .frame(width: 150, alignment: .leading)
                                .fontWeight(.bold)
                            Text(genus)
                                .foregroundStyle(Color(Colors.lightGreen))
                                .font(TextStyles.body)
                        }
                        
                        // Nombres comunes (si están disponibles)
                        if !commonNames.isEmpty {
                            HStack(spacing: 10) {
                                Text("Nombres Comunes:")
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                                    .frame(width: 150, alignment: .leading)
                                    .fontWeight(.bold)
                                Text(commonNames.joined(separator: ", "))
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20) // Espacio inferior para el contenido
        }
        .padding()
        .background(Colors.mainGreen)
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding() // Espacio exterior adicional
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            plantName: "Rosa canina",
            family: "Rosaceae",
            genus: "Rosa",
            commonNames: ["Dog Rose", "Wild Rose"],
            imageUrl: "",
            onDismiss: {}
        )
    }
}

