//
//  File.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 12.02.2021.
//

// struct with parameters for top headlines request

import Foundation

struct GoogleNewsTopHeadlinesRequest: CreatorQueryItemsProtocol {
    let country: String
    let language: String
    let page: Int
    let pageSize: Int
}

extension GoogleNewsTopHeadlinesRequest {
 
    func createdQueryItemsFromParameters() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "language", value: self.language),
            URLQueryItem(name: "page", value: String(self.page)),
            URLQueryItem(name: "pageSize", value: String(self.pageSize)),
        ]
    }
}
