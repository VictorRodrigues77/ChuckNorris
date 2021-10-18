//
//  JokeInteractor.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import Foundation

protocol JokeInteractorInput: AnyObject {
    func loadJoke()
}

protocol JokeInteractorOutput: AnyObject {
    func onFetchJoke(joke: Joke)
    func onFetchJoke(error: Error)
}

final class JokeInteractor: JokeInteractorInput {
    
    weak var output: JokeInteractorOutput?
    
    private let network: ChuckNorrisManagerProtocol
    private let term: String

    init(term: String,
         network: ChuckNorrisManagerProtocol) {
        
        self.term = term
        self.network = network
    }
    
    func loadJoke() {
        network.fetchJokeByCategory(term: term) { result in
            switch result {
            case .success(let joke):
                self.output?.onFetchJoke(joke: joke)
            case .failure(let error):
                self.output?.onFetchJoke(error: error)
            }
        }
    }
    
}
