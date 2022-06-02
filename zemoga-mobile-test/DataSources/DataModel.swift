//
//  DataModel.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import Combine
import Foundation

final class DataModel{
    
    
    
    @Published var posts: [Post] = []
    @Published var favoritePosts: [Post] = []
    @Published var user: User = User()
    @Published var comments: [Comment] = []
    private let provider = JSONPlaceHolderAPI()
    private let postFileStorage = PostFileStorage()
    
    func LoadLocalPosts() {
        postFileStorage.load()
            .assign(to: \.posts, on: self)
            .store(in: &cancellables)
        
        postFileStorage.loadFavorites()
            .assign(to: \.favoritePosts, on: self)
            .store(in: &cancellables)
    }
    
    
    private var cancellables = Set<AnyCancellable>()
    
    private func isInFavorites (post: Post) -> Bool{
        return favoritePosts.contains(where: { $0.id == post.id})
    }
    
    func loadPostsFromAPI(){
        provider.getPosts{ (posts) in
            self.posts = posts
            self.saveLocalPosts()
        }
    }
    
    func loadFavoritePostFromRealm(){
        
    }
    
    func deletePost(post: Post){
        posts.removeAll{ $0.id == post.id }
    }
    
    func deleteAllPosts(){
        posts.removeAll()
        favoritePosts.removeAll()
    }
    
    func saveLocalPosts() {
        postFileStorage.save(posts: posts)
        postFileStorage.saveFavorites(posts: favoritePosts)
    }
    
    func toggleFavorite(id: Int){
        if(favoritePosts.contains(where: {$0.id == id})){
            favoritePosts.removeAll{ $0.id == id }
        }else{
            favoritePosts.append(posts.first(where: {$0.id == id })!)
        }
        self.saveLocalPosts()
    }
    
    func loadDefaultPosts(synchronous: Bool = false) {
        postFileStorage.loadDefault(synchronous: synchronous)
            .assign(to: \.posts, on: self)
            .store(in: &cancellables)
    }
    
    func loadPostDetails(post: Post){
        provider.getPostAuthorData(id: post.userId){ (user) in
            self.user = user
            self.provider.getCommentsForPostId(id: post.id){ (comments) in
                self.comments = comments
            }
        }
    }
    
}
extension DataModel: ObservableObject {}

/// Extension for SwiftUI previews
#if DEBUG
extension DataModel {
    static var sample: DataModel {
        let model = DataModel()
        model.loadDefaultPosts(synchronous: true)
        return model
    }
    static var sampleFavorites: DataModel {
        let model = DataModel()
        model.loadFavoritePostFromRealm()
        return model
    }
}
#endif

