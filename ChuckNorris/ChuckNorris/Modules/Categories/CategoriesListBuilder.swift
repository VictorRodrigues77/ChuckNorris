//
//  CategoriesListBuilder.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import UIKit

protocol CategoriesListBuildable: AnyObject {
    func build() -> CategoriesListViewController
}

final class CategoriesListBuilder: CategoriesListBuildable {
    func build() -> CategoriesListViewController {
        let interactor = CategoriesListInteractor(
            network: ChuckNorrisManager()
        )
        
        let router = CategoriesListRouter()
        
        let presenter = CategoriesListPresenter(
            interactor: interactor,
            router: router
        )
        
        let controller = UIStoryboard(name: "CategoriesList", bundle: nil)
            .instantiateViewController(withIdentifier: "CategoriesListViewController") as! CategoriesListViewController
        
        controller.presenter = presenter
        presenter.output = controller
        interactor.output = presenter
        
        return controller
    }
}
