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
    
    let test = GoogleNewsAPI()
    var everything = GoogleNewsEverythingRequest(topic: "COVID-19", dateFrom: "2021-02-07", dateTo: "2021-02-07", sortCriteria: .popularity)
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        test.fetchEverything(googleNewsEverythingRequest: everything)
    }


}


