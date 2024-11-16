//
//  PlantsList.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 05/09/24.
//

import SwiftUI

struct PlantsList: View {
    @State private var plants: [Plant] = [] // Lista de plantas obtenida del CSV
    @State private var csvData: String = ""

    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(Colors.mainGreen)
                    .ignoresSafeArea(edges: [.top, .leading, .trailing])
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Biblioteca")
                            .font(TextStyles.title)
                            .foregroundColor(Colors.lightGreen)
                        
                        SearchBar(text: .constant("")) // Implementar funcionalidad de búsqueda
                            .frame(width: 360)
                    }
                    .padding(.vertical, 10)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(plants) { plant in
                            Listas(plant: plant)
                        }
                    }
                }
            }
            .onAppear {
                fetchCSVData()
            }
        }
    }
    
    func fetchCSVData() {
        let urlString = "https://docs.google.com/spreadsheets/d/e/2PACX-1vRAi4pLpu5byi3XnpYdD35M9vUI3nletdWaU_qsJUlaPrcyX3dMZZgb8nBceq8wcg/pub?gid=1546508326&single=true&output=csv"
        
        guard let url = URL(string: urlString) else {
            print("URL inválida.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error al obtener datos: \(error)")
                return
            }
            
            if let data = data, let csvText = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.plants = parseCSV(csvText)
                }
            }
        }.resume()
    }
    
    func parseCSV(_ csvText: String) -> [Plant] {
        let rows = csvText.components(separatedBy: "\n")
        var plants: [Plant] = []
        
        for row in rows.dropFirst() {
            let columns = row.components(separatedBy: ",")
            if columns.count >= 13 { // Asegúrate de que haya suficientes columnas
                // Extraer imágenes de las columnas
                let images = [columns[10], columns[11], columns[12]].compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
                
                // Crear la instancia de `Plant`
                let scientificName = "\(columns[4]) \(columns[5])" // Concatenar género y especie
                let plant = Plant(
                    name: columns[9], // Nombre común
                    scientificName: scientificName,
                    points: "0", // Por defecto
                    images: images, // Arreglo de imágenes
                    order: columns[2], // Orden
                    family: columns[3], // Familia
                    genus: columns[4], // Género
                    species: columns[5] // Especie
                )
                plants.append(plant)
            }
        }
        return plants
    }
}
