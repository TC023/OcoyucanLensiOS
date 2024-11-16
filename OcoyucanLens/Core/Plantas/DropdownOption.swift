//
//  DropdownOption.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 01/10/24.
//

import SwiftUI

struct DropdownOption: View{
    @State private var chosenFilter = "Opciones"
    var body: some View{
        VStack{
            Menu {
                Button(action: {
                    chosenFilter = "Fauna recolectada"
                }, label: {
                        HStack{
                            Text("Fauna recolectada")
                            if chosenFilter == "Fauna recolectada"{
                                Image(systemName:"checkmark")
                                    .foregroundColor(Colors.mainGreen)
                        }
                    }
                })
                Button(action: {
                    chosenFilter = "Toda la fauna"
                }, label: {
                    HStack{
                        Text("Toda de fauna")
                        if chosenFilter == "Biblioteca de fauna" {
                            Image(systemName: "checkmark")
                                .foregroundColor(Colors.mainGreen)
                        }
                    }
                })
            } label: {
                Label {
                    Text(chosenFilter)
                        .font(TextStyles.small_body)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Colors.lightGreen)
                } icon: {
                    Image(systemName: "chevron.down.circle")
                        .foregroundColor(Colors.lightGreen)
                        .imageScale(.small)
                }
                .frame(width: 300, height: 30)
                .roundedBorder(borderColor: Colors.lightGreen,backgroundColor: Colors.mainGreen )
            }

        }
    }
}


struct DropdownOption_Previews: PreviewProvider{
    static var previews: some View{
        DropdownOption()
    }
}
