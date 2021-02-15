//
//  new.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 11.02.2021.
//

// create URL with input properties as endpoint and queryItems

import Foundation

struct URLCreator {
    
    let baseUrl: String
    let version: String
    let apiKey: String
    
    init(baseUrl: String, apiKey: String, version: String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.version = version
    }
    
    func createURL(endpoint: Endpoints, queryItems: CreatorQueryItemsProtocol) -> URL? {
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.path = version + endpoint.rawValue
        urlComponents?.queryItems =  queryItems.createdQueryItemsFromParameters()
        urlComponents?.queryItems?.append(URLQueryItem(name: "apiKey", value: apiKey)) 
        let urlString = urlComponents?.url?.absoluteURL
        return urlString
    }
}







