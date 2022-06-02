//
//  PostListRouter.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import SwiftUI

class PostListRouter {
  func makeDetailView(for post: Post, model: DataModel) -> some View {
      let interactor = PostDetailsInteractor(model: model)
      let presenter = PostDetailPresenter(interactor: interactor)
      return PostDetailView(presenter: presenter, post: post).environmentObject(model)
  }
}
