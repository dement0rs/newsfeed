//
//  DetailsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 18.03.2021.
//
//


import Foundation

protocol FileManagerWritingAndReadingArticle {
    func readArticle() -> Article?
    func saveArticle(_ article: Article)

   
}

class DetailsViewModel {
    let googleNewsAPI: GoogleNewsAPI
    
    var newsUrl: String
    var news: ModelForNewsCell
    var article: Article
    let newsSaver =  NewsSaver()
    
    init(googleNewsAPI: GoogleNewsAPI, newsUrl: String, news: ModelForNewsCell) {
        self.googleNewsAPI = googleNewsAPI
        self.newsUrl = news.url
        self.news = news
        self.article = news.article
        print(newsUrl)
        print(news.autor)
    }
    
    
    func myRequestForShowingNews() -> URLRequest {
        let myURL = URL(string:newsUrl)
        let myRequest = URLRequest(url: myURL!)
        return myRequest
    }
    
    func saveNews() {
        newsSaver.saveArticle(article)
        
    }
    
    
}



