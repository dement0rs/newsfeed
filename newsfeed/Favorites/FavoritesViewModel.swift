//
//  FavoritesViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 24.03.2021.
//

import Foundation

class FavoritesViewModel {
    
    let articlesGateway =  ArticlesGateway()
    var articles = [Article]()
    
    
    init() {
        if let articles = articlesGateway.readArticles() {
            self.articles = articles
        } else {
            self.articles = []
        }
    }
}
