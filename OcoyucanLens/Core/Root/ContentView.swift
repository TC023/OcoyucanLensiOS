//
//  ContentView.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 04/09/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @AppStorage("uid") var userID: String = ""

    var body: some View {
        if userID.isEmpty {
            Welcome()
        } else {
            MainTabView() 
        }
    }
}
struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
    }
    
}




