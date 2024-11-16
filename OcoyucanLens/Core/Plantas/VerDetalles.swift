//
//  VerDetalles.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 05/09/24.
//
import SwiftUI

struct VerDetalles: View {
    @Environment(\.presentationMode) var presentationMode
    let plant: Plant

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(Colors.mainGreen)
                    .ignoresSafeArea()

                VStack {
                    ImagesCarousel(plant: plant)
                        .offset(y: -120)

                    VStack(alignment: .leading) {
                        // Nombre y puntos
                        VStack(alignment: .leading) {
                            Text(plant.name)
                                .font(TextStyles.title)
                                .foregroundStyle(Color(Colors.lightGreen))
                            HStack(spacing: 3) {
                                Text(plant.points)
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)

                                Image(systemName: "star.circle.fill")
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .imageScale(.medium)
                            }
                        }
                        .padding()

                        Divider()
                            .overlay(Color(Colors.lightGreen))

                        // Detalles de la planta
                        VStack(alignment: .leading, spacing: 25) {
                            HStack(spacing: 10) {
                                Text("Nombre científico:")
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                                    .frame(width: 150, alignment: .leading)
                                    .fontWeight(.bold)
                                Text(plant.scientificName)
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            HStack(spacing: 10) {
                                Text("Orden:")
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                                    .frame(width: 150, alignment: .leading)
                                    .fontWeight(.bold)
                                Text(plant.order)
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                            }
                            HStack(spacing: 10) {
                                Text("Familia:")
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                                    .frame(width: 150, alignment: .leading)
                                    .fontWeight(.bold)
                                Text(plant.family)
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                            }
                            HStack(spacing: 10) {
                                Text("Género:")
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                                    .frame(width: 150, alignment: .leading)
                                    .fontWeight(.bold)
                                Text(plant.genus)
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                            }
                            HStack(spacing: 10) {
                                Text("Especie:")
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                                    .frame(width: 150, alignment: .leading)
                                    .fontWeight(.bold)
                                Text(plant.species)
                                    .foregroundStyle(Color(Colors.lightGreen))
                                    .font(TextStyles.body)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        .padding()
                    }
                    .offset(y: -110)

                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            CustomButton(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, color: Colors.lightGreen)
                        }
                    }
                }
            }
        }
    }
}

struct VerDetalles_Previews: PreviewProvider {
    static var previews: some View {
        VerDetalles(plant: Plant.example)
    }
}

