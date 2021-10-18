//
//  ChuckNorrisApi.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import Moya

public enum ChuckNorrisApi {
    case random
    case categories
    case category(term: String)
    case search(term: String)
}

extension ChuckNorrisApi: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: "https://api.chucknorris.io/jokes") else { fatalError() }
        return url
    }
    
    public var path: String {
        switch self {
        case .random:
            return "/random"
        case .categories:
            return "/categories"
        case .category:
            return "/random"
        case .search:
            return "/search"
        }
    }
    
    public var method: Method {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .random, .categories:
            return .requestPlain
        case .category(let term):
            return .requestParameters(parameters: ["category": term], encoding: URLEncoding.queryString)
        case .search(let term):
            return .requestParameters(parameters: ["query": term], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
