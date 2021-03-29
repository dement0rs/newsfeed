//
//  ModelForNewsCell.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 22.02.2021.
//

import Foundation

class ModelForNewsCell: Codable {

    let article: Article
    let url: String
    let autor: String
    let title: String
    let content: String
    let source: String
    let imageURL: String
    var dataForImage : Data? 
    var date = Date()
    var stringDateForShowingTimeAgo = String()
    
    init(article: Article) {
        self.article = article
        self.url = article.url
        self.autor = article.author ?? "Some autor"
        self.title = article.title
        self.content = article.content ?? "Some text"
        self.source = article.source.name
        self.imageURL = article.urlToImage ?? "Some string"
        
        date = convertDateStringToDate(inputDate: article.publishedAt)
        stringDateForShowingTimeAgo = date.timeAgoDisplay()
        
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
    func convertDateStringToDate(inputDate: String ) -> Date {
        let isoDate = inputDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let outputDate = dateFormatter.date(from:isoDate) else {
            return Date()
            
        }
        return outputDate
    }
    
}
