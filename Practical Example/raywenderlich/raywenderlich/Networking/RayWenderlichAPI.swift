//
//  Networking.swift
//  raywenderlich
//
//  Created by Andy M on 08/10/2022.
//

import Foundation

class RayWenderlichAPI : NetworkingDelegate{
    
    func getContent(from resource: Resource) async throws -> [Content] {
        
        var request = URLRequest(url: resource.url, timeoutInterval: Double.infinity)
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.httpMethod = resource.method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.utc_date_formatter)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200,
                let json = try? decoder.decode(JSONResponse.self, from: data) else {
            throw NetworkError.requestError(message: "An Error Occurred")
        }
        
        return json.data
    }
}

extension DateFormatter{
    static var utc_date_formatter : DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .gmt
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }
}
