//
//  ContentManager.swift
//  raywenderlich
//
//  Created by Andy M on 09/10/2022.
//

import Foundation

class ContentManager{
    let networkingDelegate : NetworkingDelegate
    private var allContent = [Content]()
    
    init(networkingDelegate: NetworkingDelegate = RayWenderlichAPI(),
         content: [Content] = [Content]()) {
        self.networkingDelegate = networkingDelegate
        self.allContent = content
    }
    
    func getContent(with index: Int) -> [Content]{
        if index == 0{
            return allContent
                .filter{ $0.attributes.content_type == .collection }
                .sorted{ $0.attributes.released_at > $1.attributes.released_at }
        }else if index == 1{
            return allContent
                .filter{ $0.attributes.content_type == .article }
                .sorted{ $0.attributes.released_at > $1.attributes.released_at }
        }
        return allContent.sorted{ $0.attributes.released_at > $1.attributes.released_at }
    }
    
    func getContent() async throws{
        
        guard let videos = try? await networkingDelegate.getContent(from: .videos),
            let articles = try? await networkingDelegate.getContent(from: .articles) else{
            throw NetworkError.requestError(message: "An Error Occurred")
        }
                
        self.allContent.append(contentsOf: videos)
        self.allContent.append(contentsOf: articles)
        
    }

}
