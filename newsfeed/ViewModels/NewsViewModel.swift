//
//  NewsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 15.02.2021.
//

import Foundation

class NewsViewModel {
    
    let googleNewsAPI: GoogleNewsAPI
    var everything = GoogleNewsEverythingRequest(topic: "COVID-19", dateFrom: "2021-02-18", dateTo: "2021-02-18", sortCriteria: .popularity)
    
    
    init(googleNewsAPI: GoogleNewsAPI) {
        self.googleNewsAPI = googleNewsAPI
    }
    
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
