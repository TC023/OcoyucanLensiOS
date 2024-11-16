//
//  Rewards_structure.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 03/11/24.
//

import SwiftUI

struct Reward: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var points: String
    var image: String
    var description: String
    
    
    init(name: String, points: String, image: String, description: String ) {
        self.name = name
        self.points = points
        self.image = image
        self.description = description
        
    }
    
    static let example = Reward(
        name: "2 x 1 en Papa Jhon's",
        points:"50",
        image: "img10",
        description: "Obten una pizza de sabor que quieraws al dos por uno cualquier día de la semana"
    )
}
    

