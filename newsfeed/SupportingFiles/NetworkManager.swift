//
//  Constants.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 08.02.2021.
//

import Foundation

//This file will update when the project will have more entities


  //  let apiKey = "e56c97e0c2344aa2817396a7f2deb097"
//    let url = "http://newsapi.org/v2/everything?q=apple&from=2021-02-07&to=2021-02-07&sortBy=popularity&apiKey=\(apiKey)"
    
class NetworkManager {
    
    var createdUrl = CreatingURLManager()
    
    func fetch() {
        
        guard let url = createdUrl.createURL() else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error!!!!!!!! \(error.localizedDescription)")
            }
            if let data = data, let response = response {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString!)
               // self.parseJSON(data: data)
            }
        }
        task.resume()
        
        
        
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let currentData = try decoder.decode(NewsResponse.self, from: data)
            print(currentData.status)
        } catch {
            print("some error")
            print(error.localizedDescription)
        }
        
    }
}
