//
//  UserViewModel.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 04/11/24.
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    @AppStorage("uid") private var userID: String = ""
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userLastname") private var userLastname: String = ""
    @AppStorage("userEmail") private var userEmail: String = ""
    
    init() {
        loadUserData() // Cargar datos desde almacenamiento local al iniciar
    }
    
    // Función para cargar datos desde almacenamiento local
    private func loadUserData() {
        if !userID.isEmpty {
            user = User(name: userName, lastname: userLastname, email: userEmail, uid: userID)
        } else {
            loadUserDataFromFirestore(uid: userID) // Cargar desde Firestore si no hay datos locales
        }
    }
    
    func saveUserData(_ user: User) {
        // Guardar en Firestore
        let db = Firestore.firestore()
        db.collection("user").document(user.uid).setData([
            "name": user.name,
            "lastname": user.lastname,
            "email": user.email,
            "uid": user.uid
        ]) { error in
            if let error = error {
                print("Error al guardar datos en Firestore: \(error.localizedDescription)")
            } else {
                print("Datos del usuario guardados en Firestore.")
            }
        }
        
        // Guardar en almacenamiento local @AppStorage
        userID = user.uid
        userName = user.name
        userLastname = user.lastname
        userEmail = user.email
        
        // Actualizar la variable `user` para reflejar el usuario actual en la vista
        self.user = user
        
        print("Datos del usuario guardados en @AppStorage.")
    }
    
    // Función para cargar datos desde Firestore
    func loadUserDataFromFirestore(uid: String) {
        guard !uid.isEmpty else { return }
        
        let db = Firestore.firestore()
        db.collection("user").document(uid).getDocument { [weak self] snapshot, error in
            if let data = snapshot?.data() {
                self?.user = User(
                    name: data["name"] as? String ?? "",
                    lastname: data["lastname"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    uid: uid
                )
                
                // Guardar en `@AppStorage` para acceso rápido en el futuro
                self?.userName = data["name"] as? String ?? ""
                self?.userLastname = data["lastname"] as? String ?? ""
                self?.userEmail = data["email"] as? String ?? ""
                self?.userID = uid
                
                print("Datos cargados desde Firestore y almacenados localmente.")
            } else if let error = error {
                print("Error al cargar datos de Firestore: \(error.localizedDescription)")
            }
        }
    }
    
    func registerUser(email: String, password: String, name: String, lastname: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let authResult = authResult {
                let uid = authResult.user.uid
                let newUser = User(name: name, lastname: lastname, email: email, uid: uid)
                self?.saveUserData(newUser)
            } else if let error = error {
                print("Error al registrar el usuario: \(error.localizedDescription)")
            }
        }
    }
    
    func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let authResult = authResult {
                let uid = authResult.user.uid
                self?.userID = uid  // Guardamos el UID localmente en @AppStorage
                
                // Cargar datos del almacenamiento local antes de acudir a Firestore
                if let savedName = self?.userName, !savedName.isEmpty,
                   let savedLastname = self?.userLastname, !savedLastname.isEmpty,
                   let savedEmail = self?.userEmail, !savedEmail.isEmpty {
                    // Cargar los datos desde @AppStorage si están disponibles
                    self?.user = User(name: savedName, lastname: savedLastname, email: savedEmail, uid: uid)
                    print("Datos cargados desde almacenamiento local.")
                } else {
                    // Si no están en @AppStorage, cargamos los datos desde Firestore
                    self?.loadUserDataFromFirestore(uid: uid)
                }
            } else if let error = error {
                print("Error al iniciar sesión: \(error.localizedDescription)")
            }
        }
    }
    
    // Función para cerrar sesión y eliminar datos locales
    func signOut() {
        do {
            // Cierra sesión en Firebase Authentication
            try Auth.auth().signOut()
            
            // Limpia los datos locales almacenados en `@AppStorage`
            userID = ""
            userName = ""
            userLastname = ""
            userEmail = ""
            
            // Limpia el objeto `user` para que refleje que no hay usuario activo
            self.user = nil
            
            print("Usuario ha cerrado sesión y los datos locales han sido eliminados.")
            
        } catch let error {
            print("Error al cerrar sesión: \(error.localizedDescription)")
        }
    }
}






