//
//  Home.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 17/10/24.
//

import SwiftUI

struct Home: View {
    let plant: Plant
    @State private var showProfile = false

    var body: some View {
        NavigationView{
            ZStack(alignment: .top) {
                Color(Colors.mainGreen)
                    .ignoresSafeArea(edges: [.top, .leading, .trailing])

                HStack {
                    Spacer()
                    Image("Logo_App")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                        .clipShape(Circle())
                        .padding(.trailing, 78)

                    Button(action: {
                        showProfile = true
                    }) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(Colors.lightGreen))
                            .padding(.trailing, 30)
                    }
                    .fullScreenCover(isPresented: $showProfile) {
                        MyProfile()
                    }
                }
                .padding(.top, 10)
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Conoce la flora Ocoyucan...")
                            .font(TextStyles.title)
                            .foregroundColor(Colors.lightGreen)

                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 360, height: 200)
                                .foregroundColor(Color(Colors.lightGreen))
                                .overlay(
                                    VStack{
                                        HStack (alignment: .center){
                                            
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(spacing: 15) {
                                                    ForEach(plant.images, id: \.self) { imageName in
                                                        ImageView(imageName: imageName, width: 120, height: 120)
                                                            .cornerRadius(20)
                                                    }
                                                }
                                                
                                            }
                                              
                                        }
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 5)
                                        
                                        NavigationLink(destination: PlantsList()) {
                                            Text("Conoce más")
                                                .font(TextStyles.small_body)
                                                .foregroundColor(Colors.lightGreen)
                                                .frame(width: 140, height: 22)
                                                .foregroundColor(Colors.mainGreen)
                                                .roundedBorder(borderColor: Colors.mainGreen, backgroundColor: Colors.mainGreen)
                                                
                                        }
                                        
                                    })
                        }
                        Spacer()
                            .frame(height: 10)

                        Text("Visión")
                            .font(TextStyles.title)
                            .foregroundColor(Colors.lightGreen)
                        Text("Nuestra visión es promover la restauración ecológica en México como una alternativa a las prácticas convencionales de reforestación, con el propósito de contribuir a la recuperación de ecosistemas forestales y selváticos perturbados por la actividad humana.")
                            .font(TextStyles.body)
                            .foregroundColor(Colors.lightGreen)

                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 150)
                
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(plant: Plant.example)
    }
}


