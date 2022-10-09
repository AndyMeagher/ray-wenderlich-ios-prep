//
//  Networking.swift
//  raywenderlich
//
//  Created by Andy M on 08/10/2022.
//

import Foundation

class RayWenderlichAPI : NetworkingDelegate{
    func getContent(completion: @escaping (Result<[Content], NetworkError>) -> Void){
        self.makeRequest(to: .articles) { result in
            switch result{
            case .success:
                self.makeRequest(to: .videos, completion: completion)
                break
            case .failure(let error):
                completion(.failure(NetworkError.requestError(error: error)))
                break
            }
        }
        
    }
    
    private func makeRequest(to resource: Resource, completion: @escaping (Result<[Content], NetworkError>) -> Void){
        var request = URLRequest(url: resource.url, timeoutInterval: Double.infinity)
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.httpMethod = resource.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(.failure(NetworkError.unknown))
                return
            }
            do{
                let decoder = JSONDecoder()
                let json = try decoder.decode(JSONResponse.self, from: (data))
                completion(.success(json.data))
            }catch let err {
                completion(.failure(NetworkError.requestError(error: err)))
            }
        }
        
        task.resume()
    }
}
