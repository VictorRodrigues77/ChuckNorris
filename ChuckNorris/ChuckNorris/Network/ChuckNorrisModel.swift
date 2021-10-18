//
//  ChuckNorrisModel.swift
//  ChuckNorris
//
//  Created by Victor Rodrigues on 18/10/21.
//

import Foundation

struct JokeSearch: Codable {
    let total: Int
    let result: [Joke]
}

struct Joke: Codable {
    let categories: [String]
    let createdAt: String
    let iconURL: String
    let id, updatedAt: String
    let url: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case categories = "categories"
        case createdAt = "created_at"
        case iconURL = "icon_url"
        case id = "id"
        case updatedAt = "updated_at"
        case url = "url"
        case value = "value"
    }
}
