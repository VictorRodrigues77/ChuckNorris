//
//  CategoriesListPresenter.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import Foundation

protocol CategoriesListPresenterInput: AnyObject {
    var categoriesCount: Int { get }
    func category(at index: Int) -> String?
    func selectCategory(at index: Int)
    func loadCategories()
}

protocol CategoriesListPresenterOutput: AnyObject {
    func onFetchCategories()
    func onFetchCategories(error: String)
}

final class CategoriesListPresenter: CategoriesListPresenterInput {
    
    weak var output: CategoriesListPresenterOutput?

    private var interactor: CategoriesListInteractorInput
    private let router: CategoriesListRouting

    init(interactor: CategoriesListInteractorInput,
         router: CategoriesListRouting) {
        
        self.interactor = interactor
        self.router = router
    }
    
    private(set) var categories: [String]? {
        didSet {
            self.output?.onFetchCategories()
        }
    }
    
    var categoriesCount: Int {
        return categories?.count ?? 0
    }
    
    func category(at index: Int) -> String? {
        return categories?[index] ?? nil
    }
    
    func selectCategory(at index: Int) {
        print("selectCategory: \(String(describing: categories?[index]))")
    }
    
    func loadCategories() {
        interactor.loadCategories()
    }
    
}

extension CategoriesListPresenter: CategoriesListInteractorOutput {
    func onFetchCategories(categories: [String]) {
        self.categories = categories
        self.output?.onFetchCategories()
    }
    
    func onFetchCategories(error: Error) {
        self.output?.onFetchCategories(error: error.localizedDescription)
    }
}

