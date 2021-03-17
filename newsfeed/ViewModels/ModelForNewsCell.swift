//
//  ModelForNewsCell.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 22.02.2021.
//

import Foundation

class ModelForNewsCell {

    let date: String
    let autor: String
    let title: String
    let content: String
    let source: String
    let imageURL: String
    var dataForImage : Data? 
    var dateForShowingTimeAgo = Date()
    var stringDateForShowingTimeAgo = String()
    
    init(article: Article) {
        self.date = article.publishedAt
        self.autor = article.author ?? "Some autor"
        self.title = article.title
        self.content = article.content ?? "Some text"
        self.source = article.source.name
        self.imageURL = article.urlToImage ?? "Some string"
        dateForShowingTimeAgo = foo(inputDate: date)
        stringDateForShowingTimeAgo = dateForShowingTimeAgo.getElapsedInterval()
        
        createDataForImage(stringForImage: imageURL)
    }
    
    func createDataForImage(stringForImage: String) {
        guard let url = URL(string: stringForImage) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            dataForImage = data
        } catch {
            print("ModelForNewsCell -> createDataForImage -> can`t get data from url:  \(error.localizedDescription)")
        }
        
    }
    func foo(inputDate: String ) -> Date {
        let isoDate = inputDate

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let outputDate = dateFormatter.date(from:isoDate)!
        print("date: \(outputDate)")
        return outputDate
    }
    
}

extension Date {

    func getElapsedInterval() -> String {

    let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())

    if let year = interval.year, year > 0 {
        return year == 1 ? "\(year)" + " " + "year ago" :
            "\(year)" + " " + "years ago"
    } else if let month = interval.month, month > 0 {
        return month == 1 ? "\(month)" + " " + "month ago" :
            "\(month)" + " " + "months ago"
    } else if let day = interval.day, day > 0 {
        return day == 1 ? "\(day)" + " " + "day ago" :
            "\(day)" + " " + "days ago"
    } else {
        return "a moment ago"

    }

}
}

//extension Date {
//    static func getFormattedDate(string: String , formatter:String) -> String{
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//
//        let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
//        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
//        return dateFormatterPrint.string(from: date!)
//    }
//}

//func convertDateFormatter(date: String) -> String {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//this your string date format
//    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
//    dateFormatter.locale = Locale(identifier: "your_loc_id")
//    let convertedDate = dateFormatter.date(from: date)
//
//    guard dateFormatter.date(from: date) != nil else {
//        assert(false, "no date from string")
//        return ""
//    }
//
//    dateFormatter.dateFormat = "yyyy MMM HH:mm EEEE"///this is what you want to convert format
//    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
//    let timeStamp = dateFormatter.string(from: convertedDate!)
//
//    return timeStamp
//}
