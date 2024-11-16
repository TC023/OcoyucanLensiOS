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
            ZStack {
                Color(Colors.mainGreen)
                    .ignoresSafeArea(edges:[.top,.leading,.trailing])
                ScrollView {
                    
                    VStack (alignment:.leading){
                        HStack{
                            Text("Recompensas")
                                .font(TextStyles.title)
                                .foregroundColor(Colors.lightGreen)
                            Spacer().frame(width: 135)
                            CircularSliderView(user_point: 0.75)
                        }
                        LazyVGrid(columns: columns, spacing : 20) {
                            ForEach(0 ... 4, id: \.self) { value in
                                RewardsModel(reward: Reward.example)
                            }
                        }
                    }
                    .padding(15)
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
