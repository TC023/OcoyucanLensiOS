//
//  Aechivement_structure.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 04/11/24.
//

import SwiftUI

enum AchievementLevel {
    case lock, bronze, silver, gold
}

struct Achievement: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var image: String
    var description: String
    var level: AchievementLevel
    
    init(name: String, image: String, description: String, level: AchievementLevel) {
        self.name = name
        self.image = image
        self.description = description
        self.level = level
    }
    
    static let lock_rutas = Achievement(
        name: "No level yet",
        image: "lock.fill",
        description: "No haz completado 5 rutas en Ocoyucan aún",
        level: .lock
    )
    static let lock_flora = Achievement(
        name: "No level yet",
        image: "lock.fill",
        description: "No haz recolectado 5 especies en Ocoyucan aún",
        level: .lock
    )
    
    static let bronze_rutas = Achievement(
        name: "Nivel bronce",
        image: "figure.walk",
        description: "Haz completado 5 rutas en Ocoyucan",
        level: .bronze
    )
    static let bronze_flora = Achievement(
        name: "Nivel bronce",
        image: "leaf.fill",
        description: "Haz recolectado 5 especies en Ocoyucan",
        level: .bronze
    )
    
    static let silver_rutas = Achievement(
        name: "Nivel plata",
        image: "figure.walk",
        description: "Haz completado 10 rutas en Ocoyucan",
        level: .silver
    )
    static let silver_flora = Achievement(
        name: "Nivel plata",
        image: "leaf.fill",
        description: "Haz recolectado 10 especies en Ocoyucan",
        level: .silver
    )
    
    static let gold_rutas = Achievement(
        name: "Nivel oro",
        image: "figure.walk",
        description: "Haz completado 20 rutas en Ocoyucan",
        level: .gold
    )
    
    static let gold_flora = Achievement(
        name: "Nivel oro",
        image: "leaf.fill",
        description: "Haz completado 20 rutas en Ocoyucan",
        level: .gold
    )
}
