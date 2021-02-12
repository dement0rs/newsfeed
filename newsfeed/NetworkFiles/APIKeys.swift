//////
//////  Constants.swift
//////  newsfeed
//////
//////  Created by Anna Oksanichenko on 10.02.2021.
//////
////
//import Foundation
////
////class APIKeys {
////    
////let currentApiKey = "e56c97e0c2344aa2817396a7f2deb097"
////    
////}
//Создайте класс для взаимодействия с newsapi.
//Он должен иметь базовый URL в качестве внешнего параметра.
//Единственный открытый метод должен возвращать коллекцию статей или ошибку, если таковая имеется.
//Убедитесь, что вы предоставили удобный интерфейс для настройки количества статей, страны, языка и т. Д.
//
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
//
//
//
/////////
//
//
//
///////////
//
//
//
//
//
//
//class URLBuilder {
//let baseURL: String = "beginning"
//let apiKey: String = "apikey"
//}
//
//
//
//struct GoogleNewsHeadlinesRequest {
//let country: String
//let language: String
//let page: Int
//let pageSize: Int
//}
//
//struct GoogleNewsEverythingRequest {
//    
//    enum SortCriteria: String {
//        case popularity = "popularity"
//        case relevancy = "relevancy"
//        case publishedAt = "publishedAt"
//}
//
//let topic: String
//let dateFrom: Date
//let dateTo: Date
//let sortCriteria: SortCriteria
//}
//
