//
//  NetworkingDelegate.swift
//  raywenderlich
//
//  Created by Andy M on 09/10/2022.
//

import Foundation

protocol NetworkingDelegate{
    func getContent(from resource: Resource) async throws -> [Content]
}

enum HTTPMethod : String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum NetworkError : Error{
    case requestError(message: String)
    
    var message: String{
        switch self{
        case .requestError(let message):
            return message
        }
    }
}

enum Resource : String {
    
    case articles = "articles.json"
    case videos = "videos.json"
    
    var method : HTTPMethod{
        return .get
    }
    
    var url : URL{
        return URL(string: "https://raw.githubusercontent.com/raywenderlich/ios-interview/master/Practical%20Example/\(self.rawValue)")!
    }
}
