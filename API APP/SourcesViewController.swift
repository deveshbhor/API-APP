//
//  ViewController.swift
//  API APP
//
//  Created by Devesh Bhor on 7/9/19.
//  Copyright © 2019 iOS. All rights reserved.
//
// thefts committed by each NFL Team
import UIKit

class SourcesViewController: UITableViewController {
    
    var sources = [[String: String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Colleges In Minnesota"
        let query = "https://nflarrest.com/api/v1/crime/topTeams/Theft"
       
        
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                parse(json: json)
                return
            }
        }
        loadError()
    }


    
    
    func parse(json: JSON) {
        for result in json["sources"].arrayValue {
            let Team = result["Team"].stringValue
            let Team_name = result["Team_name"].stringValue
            let Team_city = result["Team_city"].stringValue
            let arrest_count = result["arrest_count"].stringValue
            let source = ["Team": Team, "Team_name": Team_name, "Team_city": Team_city, "arrest_count": arrest_count]
            sources.append(source)
            
        }
        tableView.reloadData()
    }
    
    func loadError() {
        let alert = UIAlertController(title: "Loading Error",
                                      message: "There was a problem loading the news feed",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil) }
    
    
    
}



