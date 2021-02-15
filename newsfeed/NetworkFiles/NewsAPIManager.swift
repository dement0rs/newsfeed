//
//  Constants.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 08.02.2021.
//


import Foundation

class GoogleNewsAPI {
    
    let baseUrl: String
    let apiKey: String
    let version: String
    
    init(baseUrl: String, apiKey: String, version: String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.version = version
    }

    func fetchEverythingRequest(googleNewsEverythingRequest : GoogleNewsEverythingRequest, completionHandler: @escaping (NewsResponse) -> Void) {
        
        let creator = URLCreator(baseUrl: baseUrl, apiKey: apiKey, version: version)
        guard let url = creator.createURL(endpoint: Endpoints.everything, queryItems: googleNewsEverythingRequest) else {
            return
        }
        self.fetchData(url: url) { response in
            switch  response {
            case .failure(let error):
                print("NewsAPIManager -> fetchEverythingRequest -> \(error.code) \( error.message) ")
                
            case .success(let someSuccess):
                completionHandler(someSuccess)
            }
        }
    }
    
   private func fetchData(url: URL, completionHandler: @escaping (Result <NewsResponse, ErrorsFormat> ) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completionHandler(.failure(ErrorsFormat(status: "Error", code: "204", message: "There is no data from this URL")))
                return
            }
            do {
                let responseModel = try JSONDecoder().decode(NewsResponse.self, from: data)
                completionHandler(.success(responseModel))
            } catch {
                print(" NewsAPIManager -> fetchData -> error in decoding \n \(error)")
            }
        }
        task.resume()
    }
    
}

extension GoogleNewsAPI {
    
    // this is a func for fetching enother request with top headlines endpoint
    
    //    func fetchTopHeadlinesRequest(googleNewsHeadlinesRequest: GoogleNewsTopHeadlinesRequest ) {
    //        guard let url = creator.createURL(endp: Endpoints.topHeadlines, param: googleNewsHeadlinesRequest) else { return }
    //        self.fetchData(url: url, completionHandler: (Result<NewsResponse, ErrorsFormat>) -> Void)
    //
    //    }
    
}
