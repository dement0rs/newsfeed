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
    
    lazy var creator = URLCreator(baseUrl: self.baseUrl, apiKey: self.apiKey, version: self.version)
    
    func fetchEverythingRequest(googleNewsEverythingRequest : GoogleNewsEverythingRequest, completionHandler: @escaping (Result <NewsResponse, ErrorsFormatForHTTPSRequest> ) -> Void) {
        
        guard let url = creator.createURL(endpoint: Endpoints.everything, queryItems: googleNewsEverythingRequest) else {
            return
        }
        
        self.fetchData(url: url) { response in
            
            switch  response {
            case .failure(let error):
                print("NewsAPIManager -> fetchEverythingRequest -> \(error.code) \( error.message) ")
                completionHandler(.failure(error))
                
            case .success(let someSuccess):
                completionHandler(.success(someSuccess))
            }
        }
    }
    
    private func fetchData(url: URL, completionHandler: @escaping (Result <NewsResponse, ErrorsFormatForHTTPSRequest> ) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                guard let data = data  else {
                    completionHandler(.failure(ErrorsFormatForHTTPSRequest(status: "Error", code: String( response.statusCode) , message: "There is no data from this URL")))
                    return
                }
                do {
                    let responseModel = try JSONDecoder().decode(NewsResponse.self, from: data)
                    completionHandler(.success(responseModel))
                } catch {
                    completionHandler(.failure(ErrorsFormatForHTTPSRequest(status: "Error", code: String( response.statusCode), message: error.localizedDescription)))
                    print(" NewsAPIManager -> fetchData -> error in decoding \n \(error)")
                }
            }
        }
        task.resume()
    }
    
}

