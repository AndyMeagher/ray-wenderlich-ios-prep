//
//  Networking.swift
//  raywenderlich
//
//  Created by Andy M on 08/10/2022.
//

import Foundation

enum Endpoint {
    
    case articles
    case videos
    
    var url : URL?{
        let baseURL = "https://api.github.com/repos/raywenderlich/ios-interview/contents/Practical%20Example/"
        
        switch self {
        case .articles:
            return URL(string: "\(baseURL)articles.json")
        case .videos:
            return URL(string: "\(baseURL)videos.json")
        }
    }
}

protocol RayWenderlichAPI{
    func getArticles(completion: @escaping ()->Void)
    func getVideos(completion: @escaping ()->Void)
}

class API : RayWenderlichAPI{
    func getArticles(completion: @escaping () -> Void) {
        
    }
    
    func getVideos(completion: @escaping () -> Void) {
        
    }
}
