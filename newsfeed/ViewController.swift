//
//  ViewController.swift
//  newsfeed
//
//  Created by Nikita Levintsov on 08.02.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var test1: UILabel!
    @IBOutlet weak var test2: UILabel!
    @IBOutlet weak var test3: UILabel!
    @IBOutlet weak var test4: UILabel!
 
    let googleNewsAPI = GoogleNewsAPI(baseUrl: "https://newsapi.org", apiKey: "e56c97e0c2344aa2817396a7f2deb097", version: "/v2/")
        
    var everything = GoogleNewsEverythingRequest(topic: "COVID-19", dateFrom: "2021-02-07", dateTo: "2021-02-07", sortCriteria: .popularity)
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        googleNewsAPI.fetchEverythingRequest(googleNewsEverythingRequest: everything) { (result) in
            print(result.status)
            print(result.totalResults)
        }
        
    }


}


