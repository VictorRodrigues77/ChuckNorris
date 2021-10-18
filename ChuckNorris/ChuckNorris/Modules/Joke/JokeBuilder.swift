//
//  JokeBuilder.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import UIKit

protocol JokeBuildable: AnyObject {
    func build(term: String) -> JokeViewController
}

final class JokeBuilder: JokeBuildable {
    func build(term: String) -> JokeViewController {
        let interactor = JokeInteractor(
            term: term,
            network: ChuckNorrisManager()
        )
        
        let router = JokeRouter()
        
        let presenter = JokePresenter(
            interactor: interactor,
            router: router
        )
        
        let controller = UIStoryboard(name: "Joke", bundle: nil)
            .instantiateViewController(withIdentifier: "JokeViewController") as! JokeViewController
        
        controller.presenter = presenter
        presenter.output = controller
        interactor.output = presenter
        
        return controller
    }
}
