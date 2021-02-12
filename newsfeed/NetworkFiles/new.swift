//
//  new.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 11.02.2021.
//

import Foundation

enum Endpoints: String {
case topHeadlines = "/v2/top-headlines"
case everything = "/v2/everything"

}


struct URLCreator {

    let scheme = "https"
    let host = "newsapi.org"
 
    
    func createURL(endp: Endpoints, param: CreateArrayProtocol) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = endp.rawValue
        urlComponents.queryItems = param.createArrayOfParam()
        let urlString = urlComponents.url?.absoluteURL
        return urlString
    }
}

protocol CreateArrayProtocol {
    func createArrayOfParam() -> [URLQueryItem]
}


struct GoogleNewsEverythingRequest: CreateArrayProtocol {
    
enum SortCriteria: String {
case popularity = "popularity"
case relevancy = "relevancy"
}

let topic: String
let dateFrom: String
let dateTo: String
let sortCriteria: SortCriteria
    let apiKey  = "e56c97e0c2344aa2817396a7f2deb097"
}

extension GoogleNewsEverythingRequest {
    func createArrayOfParam() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "q", value: self.topic),
            URLQueryItem(name: "from", value: self.dateFrom),
            URLQueryItem(name: "to", value: self.dateTo),
            URLQueryItem(name: "sortBy", value: self.sortCriteria.rawValue),
            URLQueryItem(name: "apiKey", value: self.apiKey)
        ]
    }
}


struct GoogleNewsHeadlinesRequest: CreateArrayProtocol {
let country: String
let language: String
let page: Int
let pageSize: Int
    let apiKey  = "e56c97e0c2344aa2817396a7f2deb097"
}

extension GoogleNewsHeadlinesRequest {
    func createArrayOfParam() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "country", value: self.country),
            URLQueryItem(name: "language", value: self.language),
            URLQueryItem(name: "page", value: String(self.page)),
            URLQueryItem(name: "pageSize", value: String(self.pageSize)),
            URLQueryItem(name: "apiKey", value: self.apiKey)
        ]
    }
}

