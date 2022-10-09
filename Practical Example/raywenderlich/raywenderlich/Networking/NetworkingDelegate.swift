//
//  NetworkingDelegate.swift
//  raywenderlich
//
//  Created by Andy M on 09/10/2022.
//

import Foundation

protocol NetworkingDelegate{
    func getContent(completion: @escaping (Result<[Content], NetworkError>)->Void)
}

enum HTTPMethod : String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum NetworkError : Error{
    case unknown
    case requestError(error: Error)
    
    var message: String{
        switch self{
        case .requestError(let error):
            return error.localizedDescription
        default:
            return "An Error Occurred. Please Try Again."
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
