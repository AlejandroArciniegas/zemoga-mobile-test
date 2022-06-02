//
//  PostDetailPresenter.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 1/06/22.
//

import Foundation
import Combine

class PostDetailPresenter: ObservableObject{
    private let interactor: PostDetailsInteractor
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var user: User = User()
    @Published var comments: [Comment] = []
    
    init(interactor: PostDetailsInteractor){
        
        self.interactor = interactor
        
        interactor.model.$user
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
        
        interactor.model.$comments
            .assign(to: \.comments, on: self)
            .store(in: &cancellables)
    }
    
    func loadView(post: Post){
        interactor.loadPostDetails(post: post)
    }
}
