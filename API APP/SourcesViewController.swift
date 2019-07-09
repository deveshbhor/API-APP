//
//  ViewController.swift
//  API APP
//
//  Created by Devesh Bhor on 7/9/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController {

    var sources = [[String: String]]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.title = "Colleges In Minnesota"
        let query = "http://universities.hipolabs.com/search?name=minnesota"
    }


}

