//
//  Achievement_model.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 04/11/24.
//

import SwiftUI

struct Achievement_model: View {
    var achievemnt: Achievement
    
    func colorForAchievement() -> Color {
            switch achievemnt.level {
            case .lock: return Color.gray.opacity(0.5)
            case .bronze: return Color(Colors.bronze)
            case .silver: return Color(Colors.silver)
            case .gold: return Color(Colors.gold)
            }
        }
   
    
    var body: some View {
        VStack {
            VStack{
                Divider()
                    .overlay(Color(Colors.lightGreen))
            }.padding(.vertical, 35)
            VStack{
                Circle()
                    .frame(width: 250)
                    .foregroundStyle(colorForAchievement())
                    .overlay(
                        VStack {
                            Image(systemName: achievemnt.level == .lock ? "lock.fill" : achievemnt.image)
                                .resizable()
                                .foregroundStyle(Colors.lightGreen)
                                .scaledToFit()
                                .frame(width: 35)
                        }
                    )
            Text(achievemnt.name)
                .font(TextStyles.body)
                .foregroundStyle(Colors.lightGreen)
            }.padding(.vertical, 70)
            Divider()
                .overlay(Color(Colors.lightGreen))
            VStack(alignment: .center) {
                HStack(alignment: .firstTextBaseline) {
                    Text("Descripción:")
                        .font(TextStyles.sub_title)
                        .foregroundColor(Colors.lightGreen)
                        .alignmentGuide(.firstTextBaseline) { _ in 0 }
                    Text(achievemnt.description)
                        .font(TextStyles.body)
                        .foregroundColor(Colors.lightGreen)
                        .alignmentGuide(.firstTextBaseline) { _ in 0 }
                }
            }
            .padding(.vertical, 80)
            .padding(.horizontal, 10)
        }
    }
}

struct Achievement_model_Previews: PreviewProvider {
    static var previews: some View {
        Achievement_model(achievemnt: Achievement.lock_flora)
    }
}

