//
//  NewsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 15.02.2021.
//

import Foundation

class NewsViewModel {
    let googleNewsAPI = GoogleNewsAPI(baseUrl: "https://newsapi.org", apiKey: "e56c97e0c2344aa2817396a7f2deb097", version: "v2")
        
    var everything = GoogleNewsEverythingRequest(topic: "COVID-19", dateFrom: "2021-02-08", dateTo: "2021-02-08", sortCriteria: .popularity)
    
    func test() {
        googleNewsAPI.fetchEverythingRequest(googleNewsEverythingRequest: everything) { (response) in
            switch response {
            case .success(let result) :
                print(result.status)
                print(result.totalResults)
            case .failure(let error) :
                print(error.code)
                print(error.message)
            }
            
        }
    }
    
    
}
