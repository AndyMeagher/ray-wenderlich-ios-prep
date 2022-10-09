//
//  ContentManager.swift
//  raywenderlich
//
//  Created by Andy M on 09/10/2022.
//

import Foundation

class ContentManager{
    let networkingDelegate : NetworkingDelegate
    var content = [Content]()
    
    init(networkingDelegate: NetworkingDelegate = RayWenderlichAPI(),
         content: [Content] = [Content]()) {
        self.networkingDelegate = networkingDelegate
        self.content = content
    }
    
    func getContent() async throws{
        
        guard let videos = try? await networkingDelegate.getContent(from: .videos),
              let articles = try? await networkingDelegate.getContent(from: .articles) else{
            throw NetworkError.requestError(message: "An Error Occurred")
        }
                
        self.content.append(contentsOf: videos)
        self.content.append(contentsOf: articles)
        
    }

}
