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
  //  var newsUrl: String
    let newsSaver =  NewsSaver()
    
    var article: ModelForNewsCell
   // var article: Article
   
    
   var favoriteArticle = [Article]()
    
    
    init(googleNewsAPI: GoogleNewsAPI, article: ModelForNewsCell) {
        self.googleNewsAPI = googleNewsAPI
      //  self.newsUrl = article.url
        
        self.article = article
       // self.article = article.article

    }
    
    
    func myRequestForShowingNews() -> URLRequest {
        let myURL = URL(string: article.url)
        let myRequest = URLRequest(url: myURL!)
        return myRequest
    }
    
    func saveArticle() {
//        if arrayOfNews.count != 0 {
        guard let savedArticleList = newsSaver.readArticle() else {
            return
        }
        favoriteArticle = savedArticleList
//            print("count if != 0 \(arrayOfNews.count)")
//        }
        favoriteArticle.append(article.article)
        newsSaver.saveArticle(favoriteArticle)
        print("count after save \(favoriteArticle.count)")

    
       // newsSaver.saveArticle(article)
        
    }
    
    
}



