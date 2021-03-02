//
//  ModelForNewsCell.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 22.02.2021.
//

import Foundation

class ModelForNewsCell {

    let date: String
    let autor: String
    let title: String
    let content: String
    let source: String
    let imageURL: String
    var dataForImage : Data? 
    
    
    init(article: Article) {
        self.date = article.publishedAt
        self.autor = article.author ?? "Some autor"
        self.title = article.title
        self.content = article.content ?? "Some text"
        self.source = article.source.name
        self.imageURL = article.urlToImage ?? "Some string"
        createDataForImage(stringForImage: imageURL)
    }
    
    func createDataForImage(stringForImage: String) {
        guard let url = URL(string: stringForImage) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            dataForImage = data
        } catch {
            print("ModelForNewsCell -> createDataForImage -> can`t get data from url:  \(error.localizedDescription)")
        }
        
    }
    
}
