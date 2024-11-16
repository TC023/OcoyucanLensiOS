//
//  Welcome.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 04/09/24.
//
import SwiftUI

struct Welcome: View{
    var body: some View{
        ZStack{
            NavigationStack{
                Colors.mainGreen
                    .ignoresSafeArea()
                    .overlay{
                        CircleContainer()
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}
struct CircleContainer: View{
    var body: some View{
        Circle()
            .padding()
            .frame(width:600)
            .foregroundColor(Colors.lightGreen)
            .overlay(
                VStack{
                    VStack{
                        Image("Logo_App")
                            .resizable()
                            .frame(width:100, height:100)
                            .scaledToFit()
                            .clipShape(Circle())
                            .shadow(radius:10)
                        
                        Text("OCOYUCAN LENS")
                            .font(TextStyles.logo_title)
                            .foregroundColor(Colors.mainGreen)
                    }
                    .padding(.top, 40)
                    Spacer()
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: SignIn(viewModel: UserViewModel())) {
                            Text("Iniciar sesión")
                                .font(TextStyles.body)
                                .frame(width: 300, height: 60)
                                .foregroundColor(Colors.mainGreen)
                                .roundedBorder(borderColor: Colors.mainGreen)
                                .shadow(radius: 9)
                        }
                        
                        NavigationLink(destination: Register(viewModel: UserViewModel())) {
                            Text("Registrarse")
                                .font(TextStyles.body)
                                .frame(width: 300, height: 60)
                                .foregroundColor(Colors.lightGreen)
                                .roundedBorder(borderColor: Colors.mainGreen, backgroundColor: Colors.mainGreen)
                                .shadow(radius: 9)
                            
                        }
                    }
                    .padding(.bottom, 30)
                    Spacer()
                }
            )
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}


