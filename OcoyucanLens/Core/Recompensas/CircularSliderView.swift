//
//  CircularSliderView.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 03/11/24.
//

import SwiftUI

struct CircularSliderView: View {
    var user_point: Double
    let ringDiameter = 50.0
    
    var body: some View {
                ZStack {
                    Circle()
                        .trim(from: 0.0, to: 0.87)
                        .stroke(Color(Colors.grayGreen), style:StrokeStyle( lineWidth: 6, lineCap: .round))
                        .rotationEffect(Angle(degrees: 180))
                        .overlay {
                            
                            VStack{
                                Text("\(user_point * 100, specifier: "%.0f")")
                                    .font(TextStyles.small_body)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Colors.lightGreen)
                                Image(systemName:"star.circle.fill")
                                    .foregroundColor(Colors.lightGreen)
                                    .imageScale(.small)
                                
                            }
                        }
                    Circle()
                        .trim(from: 0, to: 0.9 * user_point)
                        .stroke(Color(Colors.lightGreen),
                                style: StrokeStyle(lineWidth: 6, lineCap: .round)
                        )
                        .rotationEffect(Angle(degrees: 180))
                }
                .frame(width: ringDiameter, height: ringDiameter)
                
                Spacer()
            }
}

struct CircularSliderView_Preview: PreviewProvider {
    static var previews: some View {
        CircularSliderView(user_point: 0.75)
    }
}


