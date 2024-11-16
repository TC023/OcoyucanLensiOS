//
//  SettingsRowView.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 01/10/24.
//

import SwiftUI

struct SettingsRowView: View{
    let imageName: String
    let title: String
    let description: String
    
    var body: some View{
        VStack(spacing:5){
            Text(description)
                .frame(maxWidth: .infinity, alignment: .leading)
                   .offset(x: 55)
                .font(TextStyles.body)
                .foregroundColor(Colors.lightGreen)
            HStack{
                Image(systemName: imageName)
                    .font(TextStyles.body)
                    .foregroundColor(Colors.mainGreen)
                Text(title)
                    .font(TextStyles.body)
                    .foregroundColor(Colors.mainGreen)
            }
            .padding(.horizontal, 50)
            .frame(width: 320, height: 60)
            .roundedBorder()
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider{
    static var previews: some View{
        SettingsRowView(imageName: "gear", title: "Version", description:"Hola")
    }
}
