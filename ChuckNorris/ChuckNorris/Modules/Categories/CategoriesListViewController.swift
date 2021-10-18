//
//  CategoriesListViewController.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import UIKit

final class CategoriesListViewController: UIViewController {
    
    @IBOutlet private weak var categoriesListTableView: UITableView!
    @IBOutlet private weak var categoriesListErrorLabel: UILabel!
    
    var presenter: CategoriesListPresenterInput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        prepareNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.loadCategories()
    }

}

extension CategoriesListViewController {
    private func prepareTableView() {
        categoriesListTableView.delegate = self
        categoriesListTableView.dataSource = self
    }
    
    private func prepareNavigation() {
        title = "Categories"
    }
}

extension CategoriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.categoriesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesListCell", for: indexPath)
        cell.textLabel?.text = presenter?.category(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectCategory(at: indexPath.row)
    }
}

extension CategoriesListViewController: CategoriesListPresenterOutput {
    func onFetchCategories() {
        self.categoriesListTableView.isHidden = false
        self.categoriesListTableView.reloadData()
    }
    
    func onFetchCategories(error: String) {
        self.categoriesListTableView.isHidden = true
        self.categoriesListErrorLabel.text = error
    }
}
