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
                .frame(width: 162, height: 220)
                .foregroundStyle(Color(Colors.lightGreen))
                .shadow(radius: 9)
            
            VStack(spacing: 0) {
                
                Spacer().frame(height: 105)
                
                Text(plant.name)
                    .font(TextStyles.sub_title)
                    .foregroundStyle(Color(Colors.mainGreen))
                    .frame(maxWidth: CGFloat(145), alignment: .leading)
                
                VStack(spacing: 9) {
                    
                    HStack(spacing: 3) {
                        Text(plant.points)
                            .foregroundStyle(Color(Colors.mainGreen))
                            .font(TextStyles.small_body)
                        
                        AsyncImage(url: URL(string: plant.images.first ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView() // Indicador de carga mientras se obtiene la imagen
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 162, height: 115)
                                    .clipShape(RoundedTopCorners(radius: 20, corners: [.topLeft, .topRight]))
                            case .failure:
                                Image(systemName: "photo") // Imagen de marcador de posición
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 162, height: 115)
                                    .clipShape(RoundedTopCorners(radius: 20, corners: [.topLeft, .topRight]))
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()	
                            }
                        }
                        .offset(y: -43)

                    }
                    .frame(maxWidth: CGFloat(130), alignment: .leading)
                    
                    Button(action: {showDetails = true }) {
                        Text("Ver detalles")
                            .font(TextStyles.small_body)
                            .frame(width: 140, height: 22)
                            .foregroundColor(Colors.mainGreen)
                            .roundedBorder(borderColor: Colors.mainGreen, backgroundColor: Colors.lightGreen)
                    }
                    .fullScreenCover(isPresented: $showDetails) {
                        VerDetalles(plant: plant)
                    }
                }
            }
            
            ImageView(imageName: plant.images.first ?? "", width: 162, height: 115)
                .clipShape(RoundedTopCorners(radius: 20, corners: [.topLeft, .topRight]))
                .offset(y: -54)
        }
    }
}

struct Listas_Previews: PreviewProvider {
    static var previews: some View {
        Listas(plant: Plant.example)
    }
}

