//
//  PostListInteractor.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import Foundation

class PostListInteractor {
    let model: DataModel
    
    init (model: DataModel){
        self.model = model
    }
    
    
    func deletePost(_ index: IndexSet) {
        model.posts.remove(atOffsets: index)
    }
    
    func deletePostById(post: Post){
        model.posts.removeAll{
            $0.id == post.id
        }
        model.favoritePosts.removeAll(){
            $0.id == post.id
        }
    }
    
    func deleteAll(){
        model.deleteAllPosts()
        save()
    }
    
    func save(){
        model.saveLocalPosts()
    }
    
    func loadFavoritePosts(){
        model.LoadLocalPosts()
    }
    
    func setFavorite(index: Int){
        model.toggleFavorite(id: index)
    }
}
