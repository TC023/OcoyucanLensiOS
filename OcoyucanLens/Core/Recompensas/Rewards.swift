//
//  Rewards.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 18/10/24.
//


import SwiftUI

struct Rewards: View{
    let columns = [
        GridItem(.flexible(), spacing:0)
        ]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color(Colors.mainGreen)
                    .ignoresSafeArea(edges:[.top,.leading,.trailing])
                VStack(spacing: 25){
                    Spacer()
                        .frame(height: 10)
                    HStack{
                        Text("Recompensas")
                            .font(TextStyles.title)
                            .foregroundColor(Colors.lightGreen)
                        Spacer().frame(width: 135)
                        CircularSliderView(user_point: 0.75)
                    }.padding(.horizontal, 15) 
                    ScrollView {
                        VStack {
                            LazyVGrid(columns: columns, spacing : 20) {
                                ForEach(0 ... 4, id: \.self) { value in
                                    RewardsModel(reward: Reward.example)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }
}


struct Rewards_Previews: PreviewProvider{
    static var previews: some View{
        Rewards()
    }
}
