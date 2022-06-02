//
//  ContentView.swift
//  zemoga-mobile-test
//
//  Created by Alejandro Arciniegas on 31/05/22.
//

import SwiftUI
import Refreshable
import UIKit

struct ContentView: View {
    @EnvironmentObject var model: DataModel
    init() {
        UINavigationBar.changeAppearance(clear: false)
    }
    var body: some View {
        NavigationView{
            PostListView(presenter:
                            PostListsPresenter(interactor:
                                                PostListInteractor(model: model)))
            
        }
        .navigationViewStyle(.stack)
    }
}

extension UINavigationBar {
    static func changeAppearance(clear: Bool) {
        let appearance = UINavigationBarAppearance()
        
        if clear {
            appearance.configureWithTransparentBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
