//
//  Saving.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 19.03.2021.
//

import Foundation

//Create Documents directory path method
//Create Append to path method
//Create the read method
//Save file to Documents directory
//Call the save and read methods


// хранить иннфу я буду в виде Article

class NewsSaver: FileManagerWritingAndReadingArticle {
    
    let favoriteArticle = "favoriteArticle.txt"
    
    private func documentDirectory() -> URL {
        let documentDirectory =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentDirectory
    }
    
    
    private func appendPathComponent() -> URL {
        let pathComponent = documentDirectory().appendingPathComponent(favoriteArticle)
        return pathComponent
    }
    
    func writeArticle(article: String) {
        do {
            try article.write(to: appendPathComponent(), atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readArticle() {
        do {
            let savedArticle = try String(contentsOf: appendPathComponent())
            
            for content in savedArticle.split(separator: ";") {
                print(content)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
 
    
  
}

