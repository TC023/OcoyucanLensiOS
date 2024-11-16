//
//  ContentView.swift
//  CustomCameraApp
//
//  Created by Amisha Italiya on 03/10/23.
//

import SwiftUI

struct ScannerView: View {
    @ObservedObject var viewModel = CameraViewModel()
    
    @State private var isFocused = false
    @State private var isScaled = false
    @State private var focusLocation: CGPoint = .zero
    @State private var currentZoomFactor: CGFloat = 1.0
    @State private var isIdentificationInProgress = false
    @State private var showDetailView = false
    @State private var imageUrl: String?
    @State private var plantName: String?

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(Colors.mainGreen)
                    .ignoresSafeArea(edges:[.top,.leading,.trailing])
                
                VStack(spacing: 10)  {
                    Button(action: {
                        viewModel.switchFlash()
                    }, label: {
                        Image(systemName: viewModel.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .shadow(radius: 9)
                    })
                    .foregroundColor(viewModel.isFlashOn ? Color(Colors.flashyellow) : Color(Colors.lightGreen))
                    
                    ZStack {
                        CameraPreview(session: viewModel.session) { tapPoint in
                            isFocused = true
                            focusLocation = tapPoint
                            viewModel.setFocus(point: tapPoint)
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                        .gesture(MagnificationGesture()
                            .onChanged { value in
                                self.currentZoomFactor += value - 1.0
                                self.currentZoomFactor = min(max(self.currentZoomFactor, 0.5), 10)
                                self.viewModel.zoom(with: currentZoomFactor)
                            })
                        
                        if isFocused {
                            FocusView(position: $focusLocation)
                                .scaleEffect(isScaled ? 0.8 : 1)
                                .onAppear {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)) {
                                        self.isScaled = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                            self.isFocused = false
                                            self.isScaled = false
                                        }
                                    }
                                }
                        }
                        
                        // Vista de progreso mientras se procesa la identificación
                        if isIdentificationInProgress {
                            Color(Colors.mainGreen)
                                .opacity(0.8)
                                .ignoresSafeArea()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Colors.lightGreen))
                                .scaleEffect(1.5)
                        }
                    }
                    
                    HStack {
                        PhotoThumbnail(image: $viewModel.capturedImage)
                            .offset(y:-6)
                        Spacer()
                        CaptureButton {
                            viewModel.captureImage()}
                            .offset(y:-7)
                        Spacer()
                        // Botón de Escaneo en el HStack
                        if viewModel.capturedImage != nil {
                            Button(action: {
                                identifyCapturedPlant()
                            }) {
                                VStack {
                                    Image(systemName: "qrcode")
                                        .foregroundColor(Colors.lightGreen)
                                        .font(.system(size: 35, weight: .light))
                                                                
                                    Text("Escanear flora")
                                        .font(.footnote)
                                        .foregroundColor(Colors.lightGreen)
                                }
                                .frame(width: 70, height: 75)
                                .shadow(radius: 9)
                                .offset(y:-6)
                                

                            }
                            .sheet(isPresented: $showDetailView) {
                                DetailView(result: plantName ?? "Nombre desconocido", onDismiss: {
                                    showDetailView = false
                                })
                            }
                        }
                        else {
                            Rectangle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(Colors.mainGreen)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .offset(y:-6)
                        }
                    }
                    .padding(24)
                }
            }
            .alert(isPresented: $viewModel.showAlertError) {
                Alert(
                    title: Text(viewModel.alertError.title),
                    message: Text(viewModel.alertError.message),
                    dismissButton: .default(Text(viewModel.alertError.primaryButtonTitle)) {
                        viewModel.alertError.primaryAction?()
                    }
                )
            }
            .alert(isPresented: $viewModel.showSettingAlert) {
                Alert(
                    title: Text("Warning"),
                    message: Text("Application doesn't have all permissions to use camera and microphone, please change privacy settings."),
                    dismissButton: .default(Text("Go to settings"), action: {
                        openSettings()
                    })
                )
            }
            .onAppear {
                viewModel.setupBindings()
                viewModel.requestCameraPermission()
            }
        }
    }
    
    func identifyCapturedPlant() {
        guard let capturedImage = viewModel.capturedImage else {
            viewModel.showAlertError = true
            return
        }
        
        // Mostrar el `ProgressView`
        isIdentificationInProgress = true
        
        // Llamada de identificación
        identifyPlant(image: capturedImage) { result in
            DispatchQueue.main.async {
                isIdentificationInProgress = false
                switch result {
                case .success(let (bestMatch, imageUrl)):
                    self.plantName = bestMatch  // Asignar el nombre de la planta desde la API
                    self.imageUrl = imageUrl
                    self.showDetailView = true  // Mostrar `DetailView` al terminar
                case .failure:
                    viewModel.showAlertError = true
                }
            }
        }
    }
    
    func openSettings() {
        let settingsUrl = URL(string: UIApplication.openSettingsURLString)
        if let url = settingsUrl {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

// Estructuras adicionales para los componentes usados en ScannerView

struct PhotoThumbnail: View {
    @Binding var image: UIImage?
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 9)
                
            } else {
                Rectangle()
                    .frame(width: 70, height: 70, alignment: .center)
                    .foregroundColor(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 9)
            }
        }
    }
}

struct CaptureButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color(Colors.lightGreen))
                    .frame(width: 65, height: 65, alignment: .center)
                Circle()
                    .stroke(Color(Colors.lightGreen))
                    .frame(width: 75, height: 75, alignment: .center)
            }
            .shadow(radius: 9)
        }
    }
}

struct FocusView: View {
    @Binding var position: CGPoint
    
    var body: some View {
        Circle()
            .frame(width: 70, height: 70)
            .foregroundColor(.clear)
            .border(Color.yellow, width: 1.5)
            .position(x: position.x, y: position.y)
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}



