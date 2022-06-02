//
//  Post.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import Foundation
import Combine
final class Post{
    
    @Published var userId: Int = 0
    @Published var id: Int = 0
    @Published var title: String = ""
    @Published var body: String = ""
    @Published var isFavorite: Bool = false
    let uuid: UUID //UUID for local storage
    
    init() {
        uuid = UUID()
    }
    init(userId: Int, id: Int, title:  String, body: String, isFavorite: Bool){
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
        self.isFavorite = isFavorite
        self.uuid = UUID()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self )
        userId = try container.decode(Int.self, forKey: .userId)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
        isFavorite = false
        uuid = UUID()
    }
    
    
}

extension Post: Codable {
    
    enum CodingKeys: CodingKey {
        case userId
        case id
        case title
        case body
        case isFavorite
        case uuid
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
        try container.encode(isFavorite, forKey: .isFavorite)
        try container.encode(uuid, forKey: .uuid)
    }
}
extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }
}

extension Post: Identifiable {}

extension Post: ObservableObject {}
