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

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

class NewsSaver: FileManagerWritingAndReadingArticle {

    let userDefaults = UserDefaults.standard
    
    
    // convert to data
    //save to user def
    //var newsForSaving : ModelForNewsCell
    var someKey = String()
    
    var newsArray = [ModelForNewsCell]()
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        print(UserDefaults.standard.object(forKey: key) != nil)
        return UserDefaults.standard.object(forKey: key) != nil
    }
    func testSave(news: ModelForNewsCell) {
        newsArray.append(news)
    
            do {
                try userDefaults.setObject(newsArray, forKey: "FavoriteNews")
               
                print("set")
            } catch {
                print(error.localizedDescription)
            }
    
        
    }
    
    func testShow() -> [ModelForNewsCell] {
        
        do {
            let favoriteNews = try userDefaults.getObject(forKey: "FavoriteNews", castTo: [ModelForNewsCell].self)
            print("get")
            print(favoriteNews.count)
            newsArray = favoriteNews
        } catch {
            print(error.localizedDescription)

        }
        return newsArray
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
    
    
    func writeArticle(article: String) {
        do {
            try article.write(to: appendPathComponent(), atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readArticle() {
        do {
            let savedArticle = try String(contentsOf: appendPathComponent())
            
            for content in savedArticle.split(separator: ";") {
                print(content)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
 
    
  
}

