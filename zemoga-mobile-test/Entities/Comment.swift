//
//  Comment.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import Foundation
import Combine
final class Comment{
    
    @Published var postId: Int = 0
    @Published var id: Int = 0
    @Published var name: String = ""
    @Published var body: String = ""
    @Published var isFavorite: Bool = false
    let uuid: UUID //UUID for local storage
    
    init() {
        uuid = UUID()
    }
    init(postId: Int, id: Int, name:  String, body: String, isFavorite: Bool){
        self.postId = postId
        self.id = id
        self.name = name
        self.body = body
        self.isFavorite = isFavorite
        self.uuid = UUID()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self )
        postId = try container.decode(Int.self, forKey: .postId)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        body = try container.decode(String.self, forKey: .body)
        isFavorite = false
        uuid = UUID()
    }
    
    
}

extension Comment: Codable {
    
    enum CodingKeys: CodingKey {
        case postId
        case id
        case name
        case body
        case isFavorite
        case uuid
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postId, forKey: .postId)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(body, forKey: .body)
        try container.encode(isFavorite, forKey: .isFavorite)
        try container.encode(uuid, forKey: .uuid)
    }
}
extension Comment: Equatable {
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        lhs.id == rhs.id
    }
}

extension Comment: Identifiable {}

extension Comment: ObservableObject {}
