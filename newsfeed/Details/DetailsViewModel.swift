//
//  DetailsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 18.03.2021.
//
//


import Foundation

protocol FileManagerWritingAndReadingArticle {
    func readArticles() -> [Article]?
    func getArticles(_ articles: [Article])
    
    
}

class DetailsViewModel {
    
    
    let articlesGateway =  ArticlesGateway()
    var article: Article
    var favoriteArticles = [Article]()
    
    init(article: Article) {
        self.article = article
    }
    
    func myRequestForShowingNews() -> URLRequest {
        let myURL = URL(string: article.url)
        let myRequest = URLRequest(url: myURL!)
        return myRequest
    }
    
    func saveArticle() {
        guard let savedArticleList = articlesGateway.readArticles() else {
            addArticleToList()
            return
        }
        favoriteArticles = savedArticleList
        addArticleToList()
    }
    
    
    private func addArticleToList(){
        favoriteArticles.append(article)
        articlesGateway.getArticles(favoriteArticles)
    }
}
