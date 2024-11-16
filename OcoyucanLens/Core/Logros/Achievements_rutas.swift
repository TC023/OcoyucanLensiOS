//
//  Achievements.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 04/11/24.
//

import SwiftUI

struct Achievements_rutas: View {


    var body: some View {
        NavigationView {
            ZStack{
                Color(Colors.mainGreen)
                    .ignoresSafeArea()

                VStack(alignment: .leading) {
                    HStack {
                        Text("Nivel de rutas")
                            .font(TextStyles.title)
                            .foregroundColor(Colors.lightGreen)
                    }.padding(.horizontal, 20)
                    
                
                    
                    VStack{
                        Achievement_model(achievemnt: Achievement.gold_rutas)
                            

                    }
                }
            }
        }
    }
}

struct Achievements_rutas_Previews: PreviewProvider {
    static var previews: some View {
        Achievements_rutas()
    }
}

