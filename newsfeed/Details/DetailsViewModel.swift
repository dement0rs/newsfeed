//
//  DetailsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 18.03.2021.
//
//


import Foundation

protocol FileManagerWritingAndReadingArticle {
   func writeArticle(article: String)
    func readArticle()
   
}

class DetailsViewModel {
    let googleNewsAPI: GoogleNewsAPI
    
    var newsUrl: String
    
    let newsSaver =  NewsSaver()
    
    init(googleNewsAPI: GoogleNewsAPI, newsUrl: String) {
        self.googleNewsAPI = googleNewsAPI
        self.newsUrl = newsUrl
        print(newsUrl)
    }
    
    
    func myRequestForShowingNews() -> URLRequest {
        let myURL = URL(string:newsUrl)
        let myRequest = URLRequest(url: myURL!)
        return myRequest
    }
    
}



