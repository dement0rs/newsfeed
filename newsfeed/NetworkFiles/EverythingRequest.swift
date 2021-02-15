//
//  File.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 12.02.2021.
//

// struct with parameters for everything request

import Foundation

struct GoogleNewsEverythingRequest: CreatorQueryItemsProtocol {
    
    enum SortCriteria: String {
        case popularity = "popularity"
        case relevancy = "relevancy"
        case publishedAt = "publishedAt"
    }
    
    let topic: String
    let dateFrom: String
    let dateTo: String
    let sortCriteria: SortCriteria
}

extension GoogleNewsEverythingRequest {

    func createdQueryItemsFromParameters() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "q", value: self.topic),
            URLQueryItem(name: "from", value: self.dateFrom),
            URLQueryItem(name: "to", value: self.dateTo),
            URLQueryItem(name: "sortBy", value: self.sortCriteria.rawValue),
        ]
    }
}
