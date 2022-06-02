//
//  Post.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import Foundation
import Combine
final class User{
    
    @Published var id: Int = 0
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var website: String = ""
    @Published var phone: String = ""
    let uuid: UUID //UUID for local storage
    
    init() {
        uuid = UUID()
    }
    init(id: Int, name:  String, email: String, website: String, phone: String){
        self.id = id
        self.name = name
        self.email = email
        self.website = website
        self.phone = phone
        self.uuid = UUID()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self )
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        website = try container.decode(String.self, forKey: .website)
        phone = try container.decode(String.self, forKey: .phone)
        uuid = UUID()
    }
    
    
}

extension User: Codable {
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case email
        case website
        case uuid
        case phone
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(website, forKey: .website)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(phone, forKey: .phone)
        
    }
}
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

extension User: Identifiable {}

extension User: ObservableObject {}
