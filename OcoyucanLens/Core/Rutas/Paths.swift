//
//  Paths.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 18/10/24.
//

import SwiftUI
import MapKit

struct Paths: View{
    @State private var cameraPosition: MapCameraPosition = .automatic
    var body: some View{
        NavigationView{
        ZStack{
            Map(position: $cameraPosition){
                Marker("Ocoyucan Vida y conservación A.C.", coordinate: CLLocationCoordinate2D(latitude: 18.977363, longitude: -98.297811))
                    .tint(Color(Colors.mainGreen))
                
            }
                .onAppear{
                    let SantaClaraOcoyucan = CLLocationCoordinate2D(latitude: 18.976661, longitude: -98.302223)
                    let SantaClaraOcoyucanSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
                    let SantaClaraOcoyucanRegion = MKCoordinateRegion(center: SantaClaraOcoyucan, span: SantaClaraOcoyucanSpan)
                    cameraPosition = .region(SantaClaraOcoyucanRegion)
                }
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 400, height: 350)
                    .offset(y:50)
                    .foregroundColor(Color(Colors.mainGreen))
                    .shadow(radius: 9)
                    .overlay(
                        VStack(alignment: .leading, spacing: 40) {
                            Spacer()
                                
                            
                            HStack(spacing:105){
                                Text("Rutas en Ocoyucan")
                                    .font(TextStyles.title)
                                    .foregroundColor(Colors.lightGreen)
                                Image(systemName: "square.and.arrow.up")
                                    .imageScale(.medium)
                                    .foregroundColor(Colors.lightGreen)
                            }
                            Text("Estas rutas son muy buenas, las hacene en un promedio de 30 minutos sirven para coservar el cerro de Ocoyucan")
                                .font(TextStyles.body)
                                .foregroundColor(Colors.lightGreen)
                            
                            VStack {
                                Spacer()
                                NavigationLink(destination: Paths()) {
                                    Text("Comenzar ruta")
                                        .font(TextStyles.body)
                                        .frame(width: 240, height: 45)
                                        .foregroundColor(Colors.lightGreen)
                                        .roundedBorder(borderColor: Colors.lightGreen, backgroundColor: Colors.mainGreen)
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                        }
                            .padding(20)
                    )
                }
            }
        }
    }
}

struct Paths_Previews: PreviewProvider{
    static var previews: some View{
        Paths()
    }
}
