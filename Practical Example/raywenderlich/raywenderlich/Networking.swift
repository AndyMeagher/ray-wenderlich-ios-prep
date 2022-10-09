//
//  Networking.swift
//  raywenderlich
//
//  Created by Andy M on 08/10/2022.
//

import Foundation

protocol NetworkingDelegate{
    func getContent(completion: @escaping (Result<[Content], Error>)->Void)
}

enum Resource : String {
    
    case articles = "articles.json"
    case videos = "videos.json"
    
    var url : URL{
        return URL(string: "https://raw.githubusercontent.com/raywenderlich/ios-interview/master/Practical%20Example/\(self.rawValue)")!
    }
}

struct JSONResponse : Decodable{
    let data: [Content]
}

enum ContentType : String, Decodable{
    case article, collection
}

struct Content : Decodable{
    let id: String
    let attributes: Attributes
}

struct Attributes : Decodable{
    let content_type: ContentType
    let name: String
    let description: String
}

class RayWenderlichAPI : NetworkingDelegate{
    func getContent(completion: @escaping (Result<[Content], Error>) -> Void){
        self.makeRequest(to: .articles) { result in
            switch result{
            case .success:
                self.makeRequest(to: .videos, completion: completion)
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
        
    }
    
    private func makeRequest(to resource: Resource, completion: @escaping (Result<[Content], Error>) -> Void){
        var request = URLRequest(url: resource.url, timeoutInterval: Double.infinity)
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                ///TODO Error Handling
                completion(.failure(error!))
                return
            }
            do{
                let decoder = JSONDecoder()
                let json = try decoder.decode(JSONResponse.self, from: (data))
                completion(.success(json.data))
            }catch let err {
                print(resource.rawValue)
                completion(.failure(err))
            }
        }
        
        task.resume()
    }
    
}
