//
//  Constants.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 08.02.2021.
//

import Foundation

//This file will update when the project will have more entities

//fetch data
// parsejson
//send to completionHandler result
// create class news service
//
//rename url

class GoogleNewsAPI {

    var createdUrl = URLCreator()
    
    //add input parameters like in CreatingURLManager
    
    func fetchData() {
        
        guard let url = createdUrl.createURL() else {
            return
        }
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
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let currentData = try decoder.decode(NewsResponse.self, from: data)
            print(currentData.articles.count)
        } catch {
            print("some error")
            print(error.localizedDescription)
        }
        
    }
}

//Создайте класс для взаимодействия с newsapi.
//Он должен иметь базовый URL в качестве внешнего параметра.
//Единственный открытый метод должен возвращать коллекцию статей или ошибку, если таковая имеется.
//Убедитесь, что вы предоставили удобный интерфейс для настройки количества статей, страны, языка и т. Д.

//class GoogleNewsAPI {
//let urlBuilder: URLBuilder
//public func fetchData(params: NewsFilter)
//}
//
//class URLBuilder {
//let baseURL: String
//let apiKey: String
//}
//
//enum Endpoints: String {
//case topHeadlines = "top-headlines"
//case everything = "everything"
//...
//}
//
//struct GoogleNewsHeadlinesRequest {
//let country: String
//let language: String
//let page: Int
//let pageSize: Int
//}
//
//struct GoogleNewsEverythingRequest {
//enum SortCriteria: String {
//case popularity = "popularity"
//...
//}
//
//let topic: String
//let dateFrom: Date
//let dateTo: Date
//let sortCriteria: SortCriteria
//}
//
