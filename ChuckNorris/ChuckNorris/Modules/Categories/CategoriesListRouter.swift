//
//  CategoriesListRouter.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import UIKit

protocol CategoriesListRouting: AnyObject {
    func showJoke(term: String)
}

final class CategoriesListRouter: Router, CategoriesListRouting {
    private let builder: JokeBuildable
    
    init(builder: JokeBuildable) {
        self.builder = builder
    }
    
    func showJoke(term: String) {
        let jokeBuilder = builder.build(term: term)
        guard let controller = topNavController else { return }
        controller.pushViewController(jokeBuilder, animated: true)
    }
}

