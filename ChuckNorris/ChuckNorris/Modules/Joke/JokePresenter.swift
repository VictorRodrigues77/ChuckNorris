//
//  JokePresenter.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import Foundation

protocol JokePresenterInput: AnyObject {
    func loadJoke()
    func openJoke(completion: ((URL) -> Void))
}

protocol JokePresenterOutput: AnyObject {
    func showProgress()
    func hideProgress()
    func onFetchJoke(joke: Joke)
    func onFetchJoke(error: String)
}

final class JokePresenter: JokePresenterInput {
    
    weak var output: JokePresenterOutput?

    private let interactor: JokeInteractorInput
    private let router: JokeRouting
    
    private(set) var joke: Joke?

    init(interactor: JokeInteractorInput,
         router: JokeRouting) {
        
        self.interactor = interactor
        self.router = router
    }
    
    func loadJoke() {
        interactor.loadJoke()
    }
    
    func openJoke(completion: ((URL) -> Void)) {
        guard let joke = joke, let url = URL(string: joke.url) else { return }
        completion(url)
    }
    
}

extension JokePresenter: JokeInteractorOutput {
    func onFetchJoke(joke: Joke) {
        self.output?.showProgress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.output?.hideProgress()
            self.output?.onFetchJoke(joke: joke)
            self.joke = joke
        }
    }
    
    func onFetchJoke(error: Error) {
        self.output?.onFetchJoke(error: error.localizedDescription)
    }
}
