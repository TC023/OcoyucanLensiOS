//
//  Plant.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 03/10/24.
//

import SwiftUI

struct Plant: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var scientificName: String // Nuevo campo para nombre científico
    var points: String
    var images: [String]
    var order: String
    var family: String
    var genus: String
    var species: String

    init(name: String, scientificName: String, points: String, images: [String], order: String, family: String, genus: String, species: String) {
        self.name = name
        self.scientificName = scientificName
        self.points = points
        self.images = images
        self.order = order
        self.family = family
        self.genus = genus
        self.species = species
    }

    static let example = Plant(
        name: "Orquídea",
        scientificName: "Phalaenopsis amabilis", // Nombre científico
        points: "25",
        images: ["img6", "img2", "img4"],
        order: "Asparagales",
        family: "Orchidaceae",
        genus: "Phalaenopsis",
        species: "amabilis"
    )
}
