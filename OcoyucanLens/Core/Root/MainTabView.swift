//
//  MainTabView.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 24/10/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View{
        TabView {
            Home(plant: Plant.example)
                .tabItem {
                    Image(systemName: "house")
                    Text("Inicio")
                }
            
            Rewards()
                .tabItem {
                    Image(systemName: "trophy")
                    Text("Recompensas")
                }
            
            ScannerView()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Escaneo")
                }
            
            PlantsList()
                .tabItem {
                    Image(systemName: "leaf")
                    Text("Flora")
                }
            Paths()
                .tabItem {
                    Image(systemName: "map")
                    Text("Rutas")
                }
            
        }
        .tint(Color(Colors.mainGreen))
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        
    }
    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


