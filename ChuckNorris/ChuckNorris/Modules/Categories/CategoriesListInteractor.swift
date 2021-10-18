//
//  CategoriesListInteractor.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import Foundation

protocol CategoriesListInteractorInput: AnyObject {
    func loadCategories()
}

protocol CategoriesListInteractorOutput: AnyObject {
    func onFetchCategories(categories: [String])
    func onFetchCategories(error: Error)
}

final class CategoriesListInteractor: CategoriesListInteractorInput {
    
    weak var output: CategoriesListInteractorOutput?
    
    private let network: ChuckNorrisManagerProtocol

    init(network: ChuckNorrisManagerProtocol) {
        self.network = network
    }
    
    func loadCategories() {
        network.fetchCategories { result in
            switch result {
            case .success(let categories):
                self.output?.onFetchCategories(categories: categories)
            case .failure(let error):
                self.output?.onFetchCategories(error: error)
            }
        }
    }
    
}

