//
//  ChuckNorrisManager.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import Moya

protocol ChuckNorrisManagerProtocol {
    var provider: MoyaProvider<ChuckNorrisApi> { get }
    
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void)
    func fetchJokeByCategory(term: String, completion: @escaping (Result<Joke, Error>) -> Void)
}

class ChuckNorrisManager: ChuckNorrisManagerProtocol {
    var provider = MoyaProvider<ChuckNorrisApi>(plugins: [NetworkLoggerPlugin()])
    
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        request(target: .categories, completion: completion)
    }
    
    func fetchJokeByCategory(term: String, completion: @escaping (Result<Joke, Error>) -> Void) {
        request(target: .category(term: term), completion: completion)
    }
}

private extension ChuckNorrisManager {
    private func request<T: Decodable>(target: ChuckNorrisApi, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
