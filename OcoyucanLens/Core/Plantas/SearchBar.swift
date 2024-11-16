//
//  SearchBar.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 01/10/24.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View{
       VStack{
           HStack{
               Image(systemName: "magnifyingglass")
                   .foregroundColor(Colors.mainGreen)
               TextField("Alguna flora en especial?", text: $text)
                   .foregroundColor(Colors.mainGreen)
                   .font(TextStyles.body)
            }
        }
           .padding(.horizontal, 50)
           .frame(width: 360, height: 70)
           .roundedBorder()
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var text = ""

    static var previews: some View {
        SearchBar(text: $text)
    }
}


