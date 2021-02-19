//
//  NewsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 15.02.2021.
//

protocol DelegateProtocol: class {
    func updatingData()
}

import Foundation

class NewsViewModel {
    
    let googleNewsAPI: GoogleNewsAPI
    let modelForNewsCell = ModelForNewsCell()
    var everything = GoogleNewsEverythingRequest(topic: "COVID-19", dateFrom: "2021-02-18", dateTo: "2021-02-18", sortCriteria: .popularity)
    
   weak var delegate: DelegateProtocol?
    
    
    init(googleNewsAPI: GoogleNewsAPI) {
        self.googleNewsAPI = googleNewsAPI
    }
    
    func test(  handler: @escaping () -> Void ) {
        googleNewsAPI.fetchEverythingRequest(googleNewsEverythingRequest: everything) { (response) in
           
            DispatchQueue.main.async {
            
                switch response {
                case .success(let result) :
                    
                    self.modelForNewsCell.date = result.articles[0].publishedAt
                    self.modelForNewsCell.autor = result.articles[0].author ?? "Autor: No name"
                    print("autor")
                    print(self.modelForNewsCell.autor)
                    self.modelForNewsCell.name = result.articles[0].title
                    self.modelForNewsCell.text = result.articles[0].content ?? "Some text"
                    self.modelForNewsCell.source = result.articles[0].source.name
                    
                    print(result.status)
                    print(result.totalResults)
                    
                   
                case .failure(let error) :
                    print(error.code)
                    print(error.message)
                }
            print("disp test")
             //   self.delegate?.updatingData()
                handler()
            }
    }
        
    }
    
    
}

class ModelForNewsCell {
    var date = ""
    var autor = ""
    var name = ""
    var text = ""
    var source  = ""
}
