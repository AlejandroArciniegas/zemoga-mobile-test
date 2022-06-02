//
//  APIProvider.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import Foundation
class JSONPlaceHolderAPI {
    
    func getPosts(completion:@escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
    
    func getPostAuthorData(id: Int ,completion:@escaping (User) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users?id=\(id)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let user = try! JSONDecoder().decode([User].self, from: data!)
            print("User Objects: ")
            print(user.count)
            DispatchQueue.main.async {
                if(user.count<=0){
                    completion(User())
                }else{
                    completion(user[0])
                }
            }
        }
        .resume()
    }
    
    func getCommentsForPostId(id: Int , completion:@escaping ([Comment]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(id)") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let comments = try! JSONDecoder().decode([Comment].self, from: data!)
            DispatchQueue.main.async {
                completion(comments)
            }
        }
        .resume()
    }
}
