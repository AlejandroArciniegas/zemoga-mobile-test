//
//  PostListPresenter.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import SwiftUI
import Combine

class PostListsPresenter: ObservableObject{
    private let interactor: PostListInteractor
    private let router = PostListRouter()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var posts: [Post] = []
    @Published var favoritePosts: [Post] = []
    
    init(interactor: PostListInteractor){
        self.interactor = interactor
        
        interactor.model.$posts
            .assign(to: \.posts, on: self)
            .store(in: &cancellables)
        
        interactor.model.$favoritePosts
            .assign(to: \.favoritePosts, on: self)
            .store(in: &cancellables)
    }
    
    func loadFavoritePosts(){
    }
    
    func cachePosts(){
        interactor.save()
    }
    
    func deletePost(_ index: IndexSet) {
        interactor.deletePost(index)
        self.cachePosts()
    }
    
    func deleteByID(post: Post){
        interactor.deletePostById(post: post)
    }
    
    func makeDeleteButton() -> some View {
        Button(action: deleteAll) {
            Image(systemName: "trash")
        }
    }
    func deleteAll(){
        interactor.deleteAll()
    }
    func loadFromAPI(){
        interactor.model.loadPostsFromAPI()
    }
    func loadLocal() {
        interactor.model.LoadLocalPosts()
    }
    func setFavorite(index: Int){
        interactor.setFavorite(index: index)
    }
    func linkBuilder<Content: View>(for post: Post, @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: post, model: interactor.model)) {
            content()
        }
    }
}
