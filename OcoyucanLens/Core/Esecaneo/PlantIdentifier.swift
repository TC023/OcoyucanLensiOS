//
//  PlantIdentifier.swift
//  OcoyucanLens
//
//  Created by sofia zugasti on 11/11/24.
//

import Foundation
import UIKit

func identifyPlant(image: UIImage, completion: @escaping (Result<(String, String?), Error>) -> Void) {
    let baseUrl = "https://my-api.plantnet.org/v2/identify/all"
    let apiKey = "2b10swecBHR4jCIoBBGyF4eEA"
    let organ = "flower"
    let urlString = "\(baseUrl)?include-related-images=true&no-reject=true&nb-results=1&lang=es&type=kt&api-key=\(apiKey)"
    
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "URL inválida", code: 0, userInfo: nil)))
        return
    }
    
    guard let imageData = image.jpegData(compressionQuality: 0.8) else {
        completion(.failure(NSError(domain: "No se pudo convertir la imagen", code: 0, userInfo: nil)))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let boundary = UUID().uuidString
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    let body = NSMutableData()
    
    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"organs\"\r\n\r\n".data(using: .utf8)!)
    body.append("\(organ)\r\n".data(using: .utf8)!)
    
    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"images\"; filename=\"plant_image.jpeg\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
    body.append(imageData)
    body.append("\r\n".data(using: .utf8)!)
    
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    request.httpBody = body as Data
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "Respuesta vacía", code: 0, userInfo: nil)))
            return
        }
        
        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let results = jsonResponse["results"] as? [[String: Any]],
               let firstResult = results.first,
               let species = firstResult["species"] as? [String: Any],
               let bestMatch = species["scientificNameWithoutAuthor"] as? String,
               let images = firstResult["images"] as? [[String: Any]],
               let imageUrl = images.first?["url"] as? [String: Any],
               let imageLink = imageUrl["o"] as? String {
                
                completion(.success((bestMatch ,imageLink)))
            } else {
                completion(.failure(NSError(domain: "Formato de respuesta no válido", code: 0, userInfo: nil)))
            }
        } catch {
            completion(.failure(error))
        }
    }.resume()
}
