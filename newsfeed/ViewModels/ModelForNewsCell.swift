//
//  ModelForNewsCell.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 22.02.2021.
//

import Foundation

class ModelForNewsCell {

    var date: String
    var autor: String
    var title: String
    var content: String
    var source: String
    var imageString: String
    var dataForImage = Data()

    
    init(article: Article) {
        self.date = article.publishedAt
        self.autor = article.author ?? "Some autor"
        self.title = article.title
        self.content = article.content ?? "Some text"
        self.source = article.source.name
        self.imageString = article.urlToImage ?? "Some string"
        test()
    }
    
    func test() {
        guard let url = URL(string: imageString) else { return }
        let data = try? Data(contentsOf: url)
        dataForImage = data ?? Data()
        
    }

}
