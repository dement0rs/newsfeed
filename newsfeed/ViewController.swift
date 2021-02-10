//
//  ViewController.swift
//  newsfeed
//
//  Created by Nikita Levintsov on 08.02.21.
//

import UIKit

class ViewController: UIViewController {

    let test = GoogleNewsAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test.fetchData()
        
    }


}


