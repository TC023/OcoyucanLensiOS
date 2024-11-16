//
//  validationView.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 30/10/24.
//

import Foundation

// Validación de contraseña
func isValidPassword(_ password: String) -> Bool {
    // Mínimo de 6 caracteres, al menos una mayúscula y un carácter especial
    let passwordRegex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$"
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    return passwordTest.evaluate(with: password)
}

// Validación de email
func isValidEmail(_ email: String) -> Bool {
    // Regex de email
    let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailTest.evaluate(with: email)
}

