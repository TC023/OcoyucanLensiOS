//
//  Listas.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 05/09/24.
//

import SwiftUI

struct Listas: View {
    let plant: Plant
    @State private var showDetails = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 162, height: 230)
                .foregroundStyle(Color(Colors.lightGreen))
                .shadow(radius: 9)
            
            VStack {
                VStack {
                    AsyncImage(url: URL(string: plant.images.first ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 162, height: 115)
                                .clipShape(RoundedTopCorners(radius: 20, corners: [.topLeft, .topRight]))
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 162, height: 115)
                                .clipShape(RoundedTopCorners(radius: 20, corners: [.topLeft, .topRight]))
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                .offset(y: -20)
                
                VStack(alignment: .leading, spacing: 4) { // Añade `spacing` para mejor separación
                    Text(plant.name)
                        .font(TextStyles.sub_title)
                        .foregroundStyle(Color(Colors.mainGreen))
                        .lineLimit(2) // Limita el texto a 2 líneas
                        .frame(maxWidth: 145, alignment: .leading) // Asegura que el ancho no desborde
                    
                    HStack(spacing: 3) {
                        Text(plant.points)
                            .foregroundStyle(Color(Colors.mainGreen))
                            .font(TextStyles.small_body)
                        Image(systemName: "star.circle.fill")
                            .foregroundStyle(Color(Colors.mainGreen))
                            .font(TextStyles.small_body)
                    }
                }
                .offset(y: -20)
                
                Spacer() // Asegura que haya espacio en el layout
                
                Button(action: { showDetails = true }) {
                    Text("Ver detalles")
                        .font(TextStyles.small_body)
                        .frame(width: 140, height: 22)
                        .foregroundColor(Colors.mainGreen)
                        .roundedBorder(borderColor: Colors.mainGreen, backgroundColor: Colors.lightGreen)
                }
                .padding(.top, 10) // Añade espacio superior si es necesario
                .fullScreenCover(isPresented: $showDetails) {
                    VerDetalles(plant: plant)
                }
            }
            .frame(width: 160, height: 210) // Fija el tamaño del `VStack` para evitar sobrepasar
        }
    }
}

struct Listas_Previews: PreviewProvider {
    static var previews: some View {
        Listas(plant: Plant.example)
    }
}


