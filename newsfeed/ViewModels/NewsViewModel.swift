//
//  NewsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 15.02.2021.
//

import Foundation

protocol NewsViewModelDelegateProtocol: class {
    func updateDataForShowingNews()
}


class NewsViewModel {
    
    let googleNewsAPI: GoogleNewsAPI
    
    var indexOfAppendingArticle = 0
    var modelsForNewsCell = [ModelForNewsCell]()
    var everything = GoogleNewsEverythingRequest(topic: "Health", dateFrom: "2021-02-22", dateTo: "2021-02-22", sortCriteria: .popularity)
    
    weak var delegate: NewsViewModelDelegateProtocol?
    
    
    init(googleNewsAPI: GoogleNewsAPI) {
        self.googleNewsAPI = googleNewsAPI
    }
    
    func showNewsByEverythingRequest() {
        googleNewsAPI.fetchEverythingRequest(googleNewsEverythingRequest: everything) { (response) in
            
            DispatchQueue.main.async {
                
                switch response {
                case .success(let result) :
                    if result.totalResults > self.everything.pageSize {
                        for _ in 0...self.everything.pageSize - 1 {
                            self.createArrayOfModels(with: result.articles[self.indexOfAppendingArticle])
                        }
                    } else {
                        for _ in 0...result.totalResults - 1 {
                            self.createArrayOfModels(with: result.articles[self.indexOfAppendingArticle])

                        }
                    }
                    
                    print(result.totalResults)
                    
                    
                case .failure(let error) :
                    print("NewsViewModel -> showNewsByEverythingRequest -> can`t get successful result frrom response. Error \(error.code): \(error.message)")
    
                }
                self.delegate?.updateDataForShowingNews()
                
            }
        }
        
    }
    
    func createArrayOfModels(with article: Article) {
        let modelForNewsCell = ModelForNewsCell(article: article)
        indexOfAppendingArticle += 1
        modelsForNewsCell.append(modelForNewsCell)
        
    }
    
}

