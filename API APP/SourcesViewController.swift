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
        self.title = "Arrests for Theft For NFL Teams"
        let query = "https://nflarrest.com/api/v1/crime/topTeams/Theft"
       
        
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
            
        }
        

        
        
    }


    
    
    func parse(json: JSON) {
        for result in json.arrayValue {
            let Team = result["Team"].stringValue
            let Team_name = result["Team_name"].stringValue
            let Team_city = result["Team_city"].stringValue
            let arrest_count = result["arrest_count"].stringValue
            let source = ["Team": Team, "Team_name": Team_name, "Team_city": Team_city, "arrest_count": arrest_count]
            sources.append(source)
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    
   
    
    func loadError() {
        DispatchQueue.main.async {
            [unowned self] in
            let alert = UIAlertController(title: "Loading Error",
                                          message: "There was a problem loading the Theft Data...someone may have stole it",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let source = sources[indexPath.row]
        cell.textLabel?.text = source["Team"]
        cell.detailTextLabel?.text = source["Team_name"]
        return cell
    }
}



