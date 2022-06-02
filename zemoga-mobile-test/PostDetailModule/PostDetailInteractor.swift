//
//  PostDetailInteractor.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 1/06/22.
//

import Foundation
class PostDetailsInteractor{
    let model: DataModel
    
    init(model: DataModel){
        self.model = model
    }
    
    func loadPostDetails(post: Post){
        model.loadPostDetails(post: post)
    }
}
