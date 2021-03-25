//
//  Saving.swift
//  newsfeed
//
//  Created by Anna Oksanichenko on 19.03.2021.
//

import Foundation

//Create Documents directory path method
//Create Append to path method
//Create the read method
//Save file to Documents directory
//Call the save and read methods


// хранить иннфу я буду в виде Article
// convert Article in Data
// save data
// read data

//protocol ObjectSavable {
//    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
//    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
//}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}


class NewsSaver {
    
    var dataToSave = Data()
    var dataToShow = [ModelForNewsCell]()
    
    
    func testEncodeAndSave(news: ModelForNewsCell){
        encode(news: news)
        writeArticle(article: dataToSave)
        print(dataToSave.count)
    }
    
    func decodeAndShow() -> [ModelForNewsCell] {
         print("dec")
        decode()
       
        return dataToShow
    }
    
    func encode(news: ModelForNewsCell) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(news)
            dataToSave = data
        } catch {
            print (ObjectSavableError.unableToEncode )
        }
    }
    
    func decode() {
        let decoder = JSONDecoder()
        do {
            let news = try decoder.decode([ModelForNewsCell].self, from: dataToSave)
            print("try")
            dataToShow = news
            print("dataToShow \(dataToShow.count)")
        }
        catch {
            print(error)
            
        }
        
    }
    
    
    let favoriteArticle = "favoriteArticle.txt"
    
    private func documentDirectory() -> URL {
        let documentDirectory =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentDirectory
    }
    private func appendPathComponent() -> URL {
        let pathComponent = documentDirectory().appendingPathComponent(favoriteArticle)
        return pathComponent
    }
    
    func writeArticle(article: Data) {
        do {
            try article.write(to: appendPathComponent())
        //    try article.write(to: appendPathComponent(), atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readArticle() {
        do {
      //      let showing = try ModelForNewsCell(from: )
            let savedArticle = try String(contentsOf: appendPathComponent())

            for content in savedArticle.split(separator: ";") {
                print(content)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    
//    func isKeyPresentInUserDefaults(key: String) -> Bool {
//        print(UserDefaults.standard.object(forKey: key) != nil)
//        return UserDefaults.standard.object(forKey: key) != nil
//    }
//    extension UserDefaults: ObjectSavable {
    //    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
    //        let encoder = JSONEncoder()
    //        do {
    //            let data = try encoder.encode(object)
    //            set(data, forKey: forKey)
    //        } catch {
    //            throw ObjectSavableError.unableToEncode
    //        }
    //    }
    //
    //    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
    //        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
    //        let decoder = JSONDecoder()
    //        do {
    //            let object = try decoder.decode(type, from: data)
    //            return object
    //        } catch {
    //            throw ObjectSavableError.unableToDecode
    //        }
    //    }
    //}
    
  //  var newsArray = [ModelForNewsCell]()
   //
   //    func testSave(news: ModelForNewsCell) {
   //        newsArray.append(news)
   //
   //            do {
   //                try userDefaults.setObject(newsArray, forKey: "FavoriteNews")
   //
   //                print("set")
   //            } catch {
   //                print(error.localizedDescription)
   //            }
   //
   //
   //    }
   //
   //    func testShow() -> [ModelForNewsCell] {
   //
   //        do {
   //            let favoriteNews = try userDefaults.getObject(forKey: "FavoriteNews", castTo: [ModelForNewsCell].self)
   //            print("get")
   //            print(favoriteNews.count)
   //            newsArray = favoriteNews
   //        } catch {
   //            print(error.localizedDescription)
   //
   //        }
   //        return newsArray
   //    }
   //
   //
  
}

