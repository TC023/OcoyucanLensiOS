//
//  RewardsModel.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 03/11/24.
//
import SwiftUI

struct RewardsModel: View {
    var reward: Reward
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 350, height: 200)
            .foregroundStyle(Color(Colors.lightGreen))
            .shadow(radius: 9)
            .overlay(
                VStack {
                    
                    HStack {
                        Text(reward.name)
                            .font(TextStyles.sub_title)
                            .foregroundStyle(Color(Colors.mainGreen))
                            .lineLimit(1)
                            
                        
                        Spacer()
                        
                        HStack {
                            Text(reward.points)
                                .foregroundStyle(Color(Colors.mainGreen))
                                .font(TextStyles.small_body)
                            
                            Image(systemName: "star.circle.fill")
                                .foregroundStyle(Color(Colors.mainGreen))
                                .imageScale(.small)
                        }
                    }
                    
                    HStack {
                        ImageView(imageName: reward.image, width: 162, height: 135)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Spacer().frame(width: 20)
                        
                        VStack(spacing:20){

                            Text(reward.description)
                                .font(TextStyles.small_body)
                                .foregroundStyle(Color(Colors.mainGreen))
                                .frame(width: 130)
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
                                label: {
                                HStack {
                                    Text("Obtener")
                                        .font(TextStyles.small_body)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .frame(width: 130, height: 35 )
                                        .foregroundColor(Colors.lightGreen)
                                        .roundedBorder(borderColor: Colors.mainGreen, backgroundColor: Colors.mainGreen)
                                        .shadow(radius: 9)
                                }
                            })
                            
                        }
                    }
                }
                    .padding(20)
            )
    }
}

struct RewardsModel_Previews: PreviewProvider {
    static var previews: some View {
        RewardsModel(reward: Reward.example)
    }
}



