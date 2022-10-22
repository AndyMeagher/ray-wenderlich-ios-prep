//
//  Content.swift
//  raywenderlich
//
//  Created by Andy M on 09/10/2022.
//

import Foundation

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
    let released_at: Date
    let description_plain_text: String
    let card_artwork_url: String
}
