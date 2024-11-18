//
//  SearchBar.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 01/10/24.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    var onCancel: () -> Void

    @State private var isSearching = false

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Colors.mainGreen)

                TextField("Alguna flora en especial?", text: $text)
                    .foregroundColor(Colors.mainGreen)
                    .font(TextStyles.body)

                Button(action: {
                    if isSearching {
                        
                        onCancel()
                        isSearching = false
                    } else {
                        
                        onSearch()
                        isSearching = true
                    }
                }) {
                    Image(systemName: isSearching ? "xmark.circle" : "arrow.forward.circle")
                        .foregroundColor(isSearching ? Colors.mainGreen : Colors.mainGreen)
                        .font(.title2)
                }
            }
        }
        .padding(.horizontal, 50)
        .frame(width: 360, height: 70)
        .roundedBorder()
    }
}






