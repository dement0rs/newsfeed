//
//  Constants.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 08.02.2021.
//

import Foundation

class GoogleNewsAPI {

    let creator = URLCreator()

    func fetchEverything(googleNewsEverythingRequest : GoogleNewsEverythingRequest) {
        guard let url = creator.createURL(endp: Endpoints.everything, param: googleNewsEverythingRequest) else { return }
        self.fetchData(url: url)
    }
    
    func fetchTopHeadlines(googleNewsHeadlinesRequest: GoogleNewsHeadlinesRequest ) {
        guard let url = creator.createURL(endp: Endpoints.topHeadlines, param: googleNewsHeadlinesRequest) else { return }
        self.fetchData(url: url)

    }
    
    
    
   private func fetchData(url: URL) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error! \(error.localizedDescription)")
            }
            if let data = data, let response = response {
                print(data)
                print("response")
                print(response)
                self.parseJSON(data: data)
            }
        }
        task.resume()
        
        
        
    }
    
  private  func parseJSON(data: Data) {
        let dataString = String(data: data, encoding: .utf8)
        print("dataString")
        print(dataString!)
        
        let decoder = JSONDecoder()
        do {
            let currentData = try decoder.decode(NewsResponse.self, from: data)
            print(currentData.articles.count)
            print(currentData.articles[0].content)
            print(currentData.totalResults)
            print(currentData.articles[0].title)
        } catch {
            print("some error")
            print(error)
        }
        
    }
}

