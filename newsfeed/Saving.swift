//
//  Saving.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 19.03.2021.
//

import Foundation

class NewsSaver: FileManagerWritingAndReadingArticle {

    let favoriteArticle = "favoriteArticle.json"
    
    private func documentDirectory() -> URL {
        let documentDirectory =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentDirectory
    }
    
    func saveArticle(_ article: Article) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(article)
            let url = documentDirectory().appendingPathComponent(favoriteArticle)
            try data.write(to: url)
            print("write")
            //print url
            print(url)
        } catch {
            print ("SaveArticle error \(error)")
        }
    }
    
    func readArticle() -> Article? {
        let decoder = JSONDecoder()
        do {
            let url = documentDirectory().appendingPathComponent(favoriteArticle)
             let data = try Data(contentsOf: url)
            let article = try decoder.decode(Article.self, from: data)
            print(article.author)
            return article
            
        } catch {
            print(error)
            return nil
        }
        
    }
    

}

