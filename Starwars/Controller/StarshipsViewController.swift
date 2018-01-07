//
//  ThirdViewControllerTableViewController.swift
//  Starwars
//
//  Created by Admin on 12/25/17.
//  Copyright © 2017 Greg Dominguez. All rights reserved.
//

import UIKit
//spaceships
class ThirdViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var starshipArr = [Starship]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("in third view did load")
        loadAllStarships(curr: "https://swapi.co/api/starships")
        
    }
    
    func loadAllStarships(curr:String){
        print(curr)
        Networking.getStarships(byPage: curr) {
            [unowned self](starship, error) in
            print("we are outside")
            //TODO: Account for error cases
            guard error == nil else{
                print(error!)
                return
            }
            guard let starship1 = starship?.results else {return }
            
            let _ = starship1.map{self.starshipArr.append($0)}
            guard let nextLoad = starship?.next else {
                self.tableView.reloadData()
                return
            }
            self.loadAllStarships(curr: nextLoad)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

typealias TableViewFunctions3 = ThirdViewController
extension TableViewFunctions3: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starshipArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "starshipCell") as? CustomStarshipCell else {
            fatalError("No cell in tableView")
        }
        cell.setPlaceholder()
        cell.loadStarImage(fromName: starshipArr[indexPath.row].name.replacingOccurrences(of: " ", with: "").folding(options: .diacriticInsensitive, locale: .current))
        cell.myName.text = starshipArr[indexPath.row].name
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Starships"
    }
}

