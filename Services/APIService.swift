//
//  APIService.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

class APIService {
    
    private init() {}
    
    static func request(
        url: String,
        method: HttpMethod = .get,
        headers: [String: String]? = nil,
        body: [String: Any]? = nil
    ) async throws -> [String: Any] {
        
        // Création de l'URL
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        // Configuration de la requête
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Ajout des headers
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Ajout du body (pour POST/PUT)
        if let body = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        // Exécution de la requête
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Vérification de la réponse HTTP
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // Décoder les données en `JSON` et gérer les caractères spéciaux
        if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            var decodedJsonObject = jsonObject
            
            // Décodage des chaînes contenant des caractères Unicode
            for (key, value) in jsonObject {
                if let jsonString = value as? String {
                    let cleanString = decodeUnicodeString(jsonString)
                    decodedJsonObject[key] = cleanString
                }
            }
            
            return decodedJsonObject
        } else {
            throw URLError(.cannotDecodeContentData)
        }
    }
    
    // Fonction pour décoder les chaînes Unicode (\uXXXX)
    private static func decodeUnicodeString(_ unicodeString: String) -> String {
        var convertedString = unicodeString
        if let data = unicodeString.data(using: .utf8),
           let attributedString = try? NSAttributedString(
               data: data,
               options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
               documentAttributes: nil
           ) {
            convertedString = attributedString.string
        }
        return convertedString
    }
}

// Enum pour les méthodes HTTP
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
