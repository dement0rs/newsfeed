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
    func isLoadingInProgress(loading: Bool)
    func setConnectionState(state: NewsViewModel.DataAvailabilityState )
}




class NewsViewModel {
    
    enum DataAvailabilityState {
        case noData
        case inProgress
        case done
        
    }
   
    
    let googleNewsAPI: GoogleNewsAPI
    
    var dataState : DataAvailabilityState {
        didSet {
            delegate?.setConnectionState(state: dataState)
            delegate?.isLoadingInProgress(loading: isIndicatorOfDownloadingHidden)
        }
    }
    
    var modelsForNewsCell = [ModelForNewsCell]()
    var everything = GoogleNewsEverythingRequest(topic: "COVID-19", dateFrom: "2021-03-02", dateTo: "2021-03-02", sortCriteria: .popularity)
    
    weak var delegate: NewsViewModelDelegate?
    var isIndicatorOfDownloadingHidden = false
//    var isIndicatorOfDownloadingHidden = true {
//        didSet {
//            delegate?.isLoadingInProgress(loading: isIndicatorOfDownloadingHidden)
//        }
//    }
    
    init(googleNewsAPI: GoogleNewsAPI) {
        self.googleNewsAPI = googleNewsAPI
        self.dataState = .noData
    }
    
    func showNewsByEverythingRequest() {
        
        googleNewsAPI.fetchEverythingRequest(googleNewsEverythingRequest: everything) { (response) in
            self.dataState = .inProgress
            self.isIndicatorOfDownloadingHidden = false

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
                self.dataState = .done
                self.isIndicatorOfDownloadingHidden = true
                self.delegate?.updateDataForShowingNews()
                
              
            }
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

