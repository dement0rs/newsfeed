//
//  NewsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 15.02.2021.
//

protocol NewsViewModelDelegateProtocol: class {
    func updatingData()
}

import Foundation

class NewsViewModel {
    
    let googleNewsAPI: GoogleNewsAPI
    
    var index = 0
    let totalIndex = 20
    var modelsForNewsCell = [ModelForNewsCell]()
    var everything = GoogleNewsEverythingRequest(topic: "Health", dateFrom: "2021-02-22", dateTo: "2021-02-22", sortCriteria: .popularity)
    
    weak var delegate: NewsViewModelDelegateProtocol?
    
    
    init(googleNewsAPI: GoogleNewsAPI) {
        self.googleNewsAPI = googleNewsAPI
    }
    
    func test() {
        googleNewsAPI.fetchEverythingRequest(googleNewsEverythingRequest: everything) { (response) in
            
            DispatchQueue.main.async {
                
                switch response {
                case .success(let result) :
                    if result.totalResults > self.everything.pageSize {
                        for _ in 0...self.everything.pageSize - 1 {
                            self.createArrayOfModels(with: result.articles[self.index])
                        }
                    } else {
                        for _ in 0...result.totalResults - 1 {
                            self.createArrayOfModels(with: result.articles[self.index])

                        }
                    }
                    
                    print(result.totalResults)
                    
                    
                case .failure(let error) :
                    print(error.code)
                    print(error.message)
                }
                self.delegate?.updatingData()
                
            }
        }
        
    }
    
    func createArrayOfModels(with article: Article) {
        let modelForNewsCell = ModelForNewsCell(article: article)
        index += 1
        modelsForNewsCell.append(modelForNewsCell)
        
    }
    
}

