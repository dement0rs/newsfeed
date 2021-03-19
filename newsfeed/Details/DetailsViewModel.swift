//
//  DetailsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 18.03.2021.
//
//

// мне нужно создать проотокол, который будет выполнять функцию сохранения данных (новости)

// создать класс, который будет реализовывать этот протокол
//временно там прописать юзер дефолтс, а потом заменить на файловую систему
//
//
//


// file manager
// article codable
import Foundation

class DetailsViewModel {
    var googleNewsAPI: GoogleNewsAPI
    var newsUrl: String
    
    
    var newsSaver: SavingNews
    
    init(googleNewsAPI: GoogleNewsAPI, newsUrl: String) {
        self.googleNewsAPI = googleNewsAPI
        self.newsUrl = newsUrl
    }
    
    func printNewsUrl(){
        print(newsUrl)
    }
    
    func saveNews(){
        newsSaver.saveNewsToTheList
    }
    
}


protocol SavingNews {
    func saveNewsToTheList()
}
