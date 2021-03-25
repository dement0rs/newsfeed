//
//  FavoritesViewModel.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 24.03.2021.
//

import Foundation

class FavoritesViewModel {
    
    let googleNewsAPI: GoogleNewsAPI
    let newsSaver =  NewsSaver()

    var models = [ModelForNewsCell]()
    
    
    
    init(googleNewsAPI: GoogleNewsAPI) {
        self.googleNewsAPI = googleNewsAPI
        self.models = newsSaver.decodeAndShow()
       
    }
    
   
}