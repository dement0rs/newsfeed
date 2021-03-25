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
    var news: ModelForNewsCell
    
    let newsSaver =  NewsSaver()
    
    init(googleNewsAPI: GoogleNewsAPI, newsUrl: String, news: ModelForNewsCell) {
        self.googleNewsAPI = googleNewsAPI
        self.newsUrl = news.url
        self.news = news
        print(newsUrl)
        print(news.autor)
    }
    
    
    func myRequestForShowingNews() -> URLRequest {
        let myURL = URL(string:newsUrl)
        let myRequest = URLRequest(url: myURL!)
        return myRequest
    }
    
    func saveNews() {
        newsSaver.testSave(news: news)
        
    }
}



