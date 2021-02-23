//
//  NewsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 15.02.2021.
//

import Foundation

protocol NewsViewModelDelegate: class {
    func updateDataForShowingNews()
}


class NewsViewModel {
    
    let googleNewsAPI: GoogleNewsAPI
    
    var modelsForNewsCell = [ModelForNewsCell]()
    var everything = GoogleNewsEverythingRequest(topic: "COVID-19", dateFrom: "2021-02-22", dateTo: "2021-02-22", sortCriteria: .popularity)
    
    weak var delegate: NewsViewModelDelegate?
    
    
    init(googleNewsAPI: GoogleNewsAPI) {
        self.googleNewsAPI = googleNewsAPI
    }
    
    func showNewsByEverythingRequest() {
        googleNewsAPI.fetchEverythingRequest(googleNewsEverythingRequest: everything) { (response) in
            
            DispatchQueue.main.async {
                
                switch response {
                case .success(let result) :
                    var indexOfAppendingArticle: Int = 0
                    for article in result.articles {
                       let modelForNewsCell = ModelForNewsCell(article: article)
                        self.modelsForNewsCell.append(modelForNewsCell)
                        indexOfAppendingArticle += 1
                       if indexOfAppendingArticle > self.everything.pageSize - 1 {
                          break
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
    
}

