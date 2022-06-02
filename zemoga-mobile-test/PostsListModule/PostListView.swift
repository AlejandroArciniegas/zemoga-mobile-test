//
//  PostListView.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import SwiftUI
import Refreshable

struct PostListView: View {
    
    @ObservedObject var presenter: PostListsPresenter
    
    var body: some View {
        TabView{
            VStack{
                List {
                    Section{
                        ForEach (presenter.posts, id: \.id) { item in
                            self.presenter.linkBuilder(for: item){
                                PostListCellView(post: item, presenter: self.presenter).padding(8)
                            }
                        }.onDelete(perform: presenter.deletePost)
                    } header: {
                        Text("All")
                    } footer: {
                        Text(presenter.posts.isEmpty ? "Hey, I wasn't sure if should load posts when the app is launched or when dragging down, so if you're reading this, drag down!":"\(presenter.posts.count) Posts Loaded")
                    }
                }.buttonStyle(PlainButtonStyle())
                    .listStyle(.insetGrouped)
                    .onReceive(self.presenter.$favoritePosts, perform: { posts in
                        DispatchQueue.main.async {
                            if(self.presenter.favoritePosts.count>0){
                                print("sorting")
                                self.presenter.posts.sort{self.isInFavorites(post: $0) && !self.isInFavorites(post: $1)}
                                presenter.cachePosts()
                            }
                        }
                    })
                    .refreshable {
                        await presenter.loadLocal()
                        if await (presenter.posts.count > 0){
                            print("There are posts!")
                        }else{
                            await presenter.loadFromAPI()
                        }
                    }
            }.tabItem{
                Label("All", systemImage: "list.dash")
            }.tag(1)
            VStack{
                List {
                    Section{
                        ForEach (presenter.favoritePosts, id: \.id) { item in
                            self.presenter.linkBuilder(for: item){
                                PostListCellView(post: item, presenter: self.presenter).padding(8)
                            }
                        }
                    } header: {
                        Text("Favorites")
                    } footer: {
                        Text("\(presenter.favoritePosts.count) Favorite Posts")
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .listStyle(.insetGrouped)
            }.tabItem{
                Label("Favorites", systemImage: "star.fill")
            }.tag(2)
        }.onAppear{
            presenter.loadLocal()
        }
        .navigationBarTitle("Posts App", displayMode: .inline)
        .navigationBarItems(trailing: presenter.makeDeleteButton())
        
    }
    private func isInFavorites (post: Post) -> Bool{
        return self.presenter.favoritePosts.contains(where: { $0.id == post.id})
    }
}

#if DEBUG
struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel.sample
        let interactor = PostListInteractor(model: model)
        let presenter = PostListsPresenter(interactor: interactor)
        return NavigationView {
            PostListView(presenter: presenter)
        }
    }
}
#endif
