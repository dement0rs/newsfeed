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
 
    let newsViewModel = NewsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsViewModel.test()
       
        
    }


}


