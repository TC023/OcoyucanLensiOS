//
//  Paths.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 18/10/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct Paths: View {
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @StateObject private var locationManager = LocationManager()
    @State private var isTracking = false // Estado para indicar si se está trazando la ruta
    
    var body: some View {
        NavigationView {
            ZStack {
                // Mapa con la ruta dibujada
                Map(position: $position) {
                    if !locationManager.routeCoordinates.isEmpty {
                        // Uso correcto de MapPolyline
                        MapPolyline(coordinates: locationManager.routeCoordinates)
                            .stroke(Colors.mainGreen, lineWidth: 7)
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                }
                .onAppear {
                    locationManager.requestAuthorization()
                }
                
                VStack {
                    Spacer()
                    // Caja inferior
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 400, height: 350)
                        .offset(y: 50)
                        .foregroundColor(Color(Colors.mainGreen))
                        .shadow(radius: 9)
                        .overlay(
                            VStack(alignment: .leading, spacing: 30) {
                                Spacer()
                                    .frame(height: 10)
                                HStack(spacing: 105) {
                                    Text("Rutas en Ocoyucan")
                                        .font(TextStyles.title)
                                        .foregroundColor(Colors.lightGreen)
                                }
                                Text("Estas rutas son muy buenas, las hacen en un promedio de 30 minutos sirven para conservar el cerro de Ocoyucan")
                                    .font(TextStyles.body)
                                    .foregroundColor(Colors.lightGreen)
                                
                                VStack {
                                
                                    Button(action: {
                                        if isTracking {
                                            locationManager.stopUpdatingLocation()
                                        } else {
                                            locationManager.startUpdatingLocation()
                                        }
                                        isTracking.toggle()
                                    }) {
                                        Text(isTracking ? "Detener ruta" : "Comenzar ruta")
                                            .font(TextStyles.body)
                                            .frame(width: 300, height: 60)
                                            .foregroundColor(Colors.mainGreen)
                                            .roundedBorder()
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding(20)
                        )
                }
            }
        }
    }
}

// MARK: - LocationManager
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var routeCoordinates: [CLLocationCoordinate2D] = []
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        routeCoordinates.removeAll() // Reinicia la ruta
        manager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        routeCoordinates.append(newLocation.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
}



struct Paths_Previews: PreviewProvider {
    static var previews: some View {
        Paths()
    }
}

