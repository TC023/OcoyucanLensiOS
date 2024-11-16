//
//  Achievement_flora.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 07/11/24.
//

import SwiftUI

struct Achievements_flora: View {


    var body: some View {
        NavigationView {
            ZStack{
                Color(Colors.mainGreen)
                    .ignoresSafeArea()

                VStack(alignment: .leading) {
                    HStack {
                        Text("Nivel de flora")
                            .font(TextStyles.title)
                            .foregroundColor(Colors.lightGreen)
                    }.padding(.horizontal, 20)
                
                    
                    VStack{
                        Achievement_model(achievemnt: Achievement.bronze_flora)
                            .frame(maxWidth: .infinity, alignment: .center)

                    }
                }
            }
        }
    }
}

struct Achievements_flora_Previews: PreviewProvider {
    static var previews: some View {
        Achievements_flora()
    }
}
