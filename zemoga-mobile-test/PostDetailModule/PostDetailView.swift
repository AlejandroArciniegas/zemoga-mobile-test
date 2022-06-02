//
//  PostDetailView.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//
import SwiftUI

struct PostDetailView: View {
    @ObservedObject var presenter: PostDetailPresenter
    @ObservedObject var post: Post
    
    
    var body: some View {
        
        ZStack(alignment: .top){
            VStack(alignment: .leading, spacing: 10){
                Spacer()
                Text(self.post.title.capitalizingFirstLetter()).bold().font(.system(size: 30)).frame(
                    maxWidth: .infinity,
                    alignment: .center)
                Spacer()
                Text(self.presenter.user.name.isEmpty ? "": "Written by: \(self.presenter.user.name)" ).font(.system(size: 16)).frame(
                    maxWidth: .infinity,
                    alignment: .center)
                Text(self.presenter.user.name.isEmpty ? "": "email: \(self.presenter.user.email)" ).font(.system(size: 16)).frame(
                    maxWidth: .infinity,
                    alignment: .center)
                Text(self.presenter.user.name.isEmpty ? "": "phone: \(self.presenter.user.phone)" ).font(.system(size: 16)).frame(
                    maxWidth: .infinity,
                    alignment: .center)
                Text(self.presenter.user.name.isEmpty ? "": "website: \(self.presenter.user.website)" ).font(.system(size: 16)).frame(
                    maxWidth: .infinity,
                    alignment: .center)
                
                Text(self.post.body.capitalizingFirstLetter()).font(.system(size: 25)).frame(
                    maxWidth: .infinity,
                    alignment: .center).padding(8)
                List{
                    Section{
                        ForEach( self.presenter.comments, id: \.id){
                            comment in
                            VStack{
                                Text(comment.name)
                                    .bold()
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading)
                                Text(comment.body)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading)
                            }
                        }
                        
                    }header: {
                        Text(self.presenter.comments.isEmpty ? "": "Comments")
                    }
                }.listStyle(.plain)
                
            }.onAppear{
                presenter.loadView(post: post)
            }
        }.navigationBarTitle(Text("Details"), displayMode: .inline)
    }
}
//#if DEBUG
//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        return NavigationView{
//            let model = DataModel.sample
//            let post: Post = Post(userId: 1, id: 101, title: "Title", body: "Body", isFavorite: false)
//            let interactor = PostDetailsInteractor(model: model)
//            let presenter = PostDetailPresenter(interactor: interactor)
//            PostDetailView(presenter: presenter, post: post)
//        }
//    }
//}
//#endif
