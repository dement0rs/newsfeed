//
//  DetailsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 18.03.2021.
//
//


import Foundation

protocol FileManagerWritingAndReadingArticle {
    func readArticle() -> [Article]?
    func saveArticle(_ article: [Article])
    
    
}

class DetailsViewModel {
    
    let googleNewsAPI: GoogleNewsAPI
    let newsSaver =  NewsSaver()
    var article: ModelForNewsCell
    var favoriteArticle = [Article]()
    
    init(googleNewsAPI: GoogleNewsAPI, article: ModelForNewsCell) {
        self.googleNewsAPI = googleNewsAPI
        self.article = article
    }
    
    func myRequestForShowingNews() -> URLRequest {
        let myURL = URL(string: article.url)
        let myRequest = URLRequest(url: myURL!)
        return myRequest
    }
    
    func saveArticle() {
        guard let savedArticleList = newsSaver.readArticle() else {
            return
        }
        favoriteArticle = savedArticleList
        favoriteArticle.append(article.article)
        newsSaver.saveArticle(favoriteArticle)
    }
}



