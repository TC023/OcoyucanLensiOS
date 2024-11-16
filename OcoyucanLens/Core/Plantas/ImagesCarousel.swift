//
//  ImagesCarousel.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 04/10/24.
//

import SwiftUI

struct ImagesCarousel: View {
    let plant: Plant

    var body: some View {
        TabView {
            ForEach(plant.images, id: \.self) { imageURL in
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Indicador de carga
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    case .failure:
                        Image(systemName: "photo") // Imagen de marcador de posición
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}


struct ImagesCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ImagesCarousel(plant: Plant.example)
    }
}
