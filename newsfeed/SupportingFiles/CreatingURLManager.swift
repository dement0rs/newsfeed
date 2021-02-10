//
//  CreatingURLManager.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 10.02.2021.
//

import Foundation

struct CreatingURLManager {
    
    let apiKey = APIKeys()
    // add input parameters
    func createURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/everything"
        urlComponents.queryItems = [
        URLQueryItem(name: "q", value: "apple"),
            URLQueryItem(name: "from", value: "2021-02-07"),
            URLQueryItem(name: "to", value: "2021-02-07"),
            URLQueryItem(name: "sortBy", value: "popularity"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        let urlString = urlComponents.url?.absoluteURL
        return urlString
    }
}
