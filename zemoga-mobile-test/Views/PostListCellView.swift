//
//  PostListCellView.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import SwiftUI
import Combine

struct PostListCellView: View {
    
    @ObservedObject var post: Post
    @ObservedObject var presenter: PostListsPresenter
    @State private var cancellable: AnyCancellable?
    var body: some View {
        HStack {
            Button(action: {
                presenter.deleteByID(post: post)
            }) {
                Image(systemName:"trash")
                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
            }
            Button(action: {
                presenter.setFavorite(index: post.id)
            }) {
                Image(systemName: presenter.favoritePosts.contains(where: { $0.id == post.id}) ? "star.fill" : "star")
                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
            }
            Text(self.post.title.capitalizingFirstLetter())
        }.labelStyle(CustomLabelStyle())
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

struct CustomLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
        }
    }
}

#if DEBUG
struct TripListCell_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel.sample
        let post = model.posts[0]
        let presenter = PostListsPresenter(interactor: PostListInteractor(model: model))
        return PostListCellView(post: post, presenter: presenter)
            .frame(height: 60)
            .environmentObject(model)
    }
}
#endif

