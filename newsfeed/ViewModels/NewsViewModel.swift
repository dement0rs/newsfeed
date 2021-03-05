//
//  NewsViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 15.02.2021.
//

import Foundation
import CoreGraphics

protocol NewsViewModelDelegate: class {
    func updateDataForShowingNews()
    func stateChanged(state: NewsViewModel.DataAvailabilityState )
}

class NewsViewModel {
    
    enum DataAvailabilityState {
        case empty
        case loading
        case available
        
    }
    
    weak var delegate: NewsViewModelDelegate?
    var everything = GoogleNewsEverythingRequest(topic: "COVID-19", dateFrom: "2021-03-05", dateTo: "2021-03-05", sortCriteria: .popularity)
    
    var modelsForNewsCell = [ModelForNewsCell]()
    let googleNewsAPI: GoogleNewsAPI
    var dataState : DataAvailabilityState {
        didSet {
            delegate?.stateChanged(state: dataState)
        }
    }
    
    init(googleNewsAPI: GoogleNewsAPI) {
        self.googleNewsAPI = googleNewsAPI
        self.dataState = .empty
    }
    
    func showNewsByEverythingRequest() {
        
        self.dataState = .loading
        googleNewsAPI.fetchEverythingRequest(googleNewsEverythingRequest: everything) { (response) in
            
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
            case .failure(let error) :
                print("NewsViewModel -> showNewsByEverythingRequest -> can`t get successful result frrom response. Error \(error.code): \(error.message)")
            }
            self.dataState = .available
            self.delegate?.updateDataForShowingNews()
        }
    }
    
    func calculateItemSize(for itemNumber: Int,
                           in boxSize: CGSize,
                           minHeight: CGFloat = 220,
                           horisontalSpasing: CGFloat = 10) -> CGSize {
        let fullWidth = boxSize.width
        let itemsCountForVerticalLayout: CGFloat = 2
        let itemsCountForHorisontalLayout: CGFloat = 3
        let fullWidthItemMask  = 7
        var ItemsInRRow = CGFloat( itemsCountForVerticalLayout)
        
        if boxSize.width >  boxSize.height {
            ItemsInRRow = CGFloat( itemsCountForHorisontalLayout)
        }
        let width = (boxSize.width - horisontalSpasing * (ItemsInRRow + 1)) / ItemsInRRow
        
        if (itemNumber + fullWidthItemMask) % fullWidthItemMask == 0 {
            return  CGSize(width: fullWidth, height: minHeight)
        }
        return  CGSize(width: width, height: minHeight)
        
    }
    
    
}

