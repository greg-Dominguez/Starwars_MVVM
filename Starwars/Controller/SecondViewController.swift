//
//  SecondViewController.swift
//  Starwars
//
//  Created by Admin on 12/25/17.
//  Copyright © 2017 Greg Dominguez. All rights reserved.
//

import UIKit
class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var planetGo: Planet?
    
    override func viewDidLoad() {
        print("in planet view did load")
        loadAllPlanets(curr: "https://swapi.co/api/planets")
    }
    
    var planetArr = [Planet]()

    func loadAllPlanets( curr:String){
        Networking.getPlanets(byPage: curr) {
            [unowned self](planets, error) in
            print("we are outside")
            //TODO: Account for error cases
            guard error == nil else{
                print(error!)
                return
            }
            guard let planets1 = planets?.results else {return }
            let _ = planets1.map{self.planetArr.append($0)}
            guard let nextLoad = planets?.next else {
                print(self.planetArr)
                self.tableView.reloadData()
                return}
            self.loadAllPlanets(curr: nextLoad)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.planetGo = planetArr[indexPath.row]
//        print(self.planetGo)
        performSegue(withIdentifier: "planetToDetails", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else {return}
//        guard let indexPath = self.tableView.indexPathForSelectedRow else{return}
        detailVC.planet = self.planetGo
    }

    
}

typealias TableViewFunctions2 = SecondViewController

extension TableViewFunctions2: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell") else {
            fatalError("No cell in tableView")
        }
        cell.textLabel?.text = planetArr[indexPath.row].name
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
