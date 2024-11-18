//
//  PlantsList.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 05/09/24.
//

import SwiftUI

struct PlantsList: View {
    @State private var plants: [Plant] = []
    @State private var filteredPlants: [Plant] = []
    @State private var searchText: String = ""

    let columns = [
        GridItem(.flexible(), spacing: 20), 
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                Color(Colors.mainGreen)
                    .ignoresSafeArea(edges: [.top, .leading, .trailing])

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) { // Espaciado entre los elementos del VStack
                        VStack(spacing: 17){
                            Spacer()
                                
                            HStack{
                                Text("Biblioteca")
                                    .font(TextStyles.title)
                                    .foregroundColor(Colors.lightGreen)
                                Spacer().frame(width: 135)
                                
                            }.padding(.horizontal, 20)
                        }
                        // SearchBar
                        SearchBar(
                            text: $searchText,
                            onSearch: performSearch,
                            onCancel: cancelSearch
                        )
                        .frame(width: 360)
                        .padding(.horizontal, 20) // Asegura consistencia con el texto

                        // Espaciado entre la barra de búsqueda y la lista
                        LazyVGrid(columns: columns, spacing: 20) { // Espaciado entre filas
                            ForEach(filteredPlants) { plant in
                                Listas(plant: plant)
                            }
                        }
                        .padding(.horizontal, 20) // Asegura espacio a los lados
                    }
                    .padding(.vertical, 20) // Espaciado superior e inferior del contenido
                }
            }
            .onAppear {
                fetchCSVData()
            }
        }
    }

    func performSearch() {
        if searchText.isEmpty {
            filteredPlants = plants
        } else {
            filteredPlants = plants.filter { plant in
                plant.name.localizedCaseInsensitiveContains(searchText) ||
                plant.scientificName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    func cancelSearch() {
        searchText = ""
        filteredPlants = plants
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
                    self.filteredPlants = self.plants
                }
            }
        }.resume()
    }

    func parseCSV(_ csvText: String) -> [Plant] {
        let rows = csvText.components(separatedBy: "\n")
        var plants: [Plant] = []

        for row in rows.dropFirst() {
            let columns = row.components(separatedBy: ",")
            if columns.count >= 13 {
                let images = [columns[11], columns[12], columns[13]].compactMap {
                    $0.trimmingCharacters(in: .whitespacesAndNewlines)
                }.filter { !$0.isEmpty }

                let scientificName = "\(columns[4]) \(columns[5])"
                let plant = Plant(
                    name: columns[9],
                    scientificName: scientificName,
                    points: columns[14],
                    images: images,
                    order: columns[2],
                    family: columns[3],
                    genus: columns[4],
                    species: columns[5]
                )
                plants.append(plant)
            }
        }
        return plants
    }
}

