//
//  DetailView.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 12/11/24.
//
import SwiftUI

struct DetailView: View {
    var result: String
    var onDismiss: () -> Void

    var body: some View {
            VStack {
                // Barra superior con el botón de retroceso
                HStack {
                    Button(action: {
                        onDismiss() // Ejecuta la acción de cierre
                    }) {
                        Image(systemName: "chevron.compact.left")
                            .foregroundColor(Colors.lightGreen)
                    }
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                // Muestra el resultado de la identificación
                Text(result)
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
            .padding()
            .background(Colors.mainGreen)
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding() // Espacio adicional alrededor de la vista
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(result: "hola") {
        }
    }
}

