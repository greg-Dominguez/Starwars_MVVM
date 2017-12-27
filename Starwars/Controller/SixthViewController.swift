//
//  SixthViewController.swift
//  Starwars
//
//  Created by Admin on 12/26/17.
//  Copyright © 2017 Greg Dominguez. All rights reserved.
//

import UIKit

class SixthViewController: UIViewController{


    @IBOutlet weak var tableView: UITableView!
    

var specieArr = [Specie]()

override func viewDidLoad() {
    super.viewDidLoad()
    print("in fourth view did load")
    loadAllSpecies(curr: "https://swapi.co/api/species")
}

func loadAllSpecies(curr:String){
    Networking.getSpecie(byPage: curr) {
        [unowned self](specie, error) in
        print("we are outside")
        //TODO: Account for error cases
        guard error == nil else{
            print(error!.localizedDescription)
            return
        }
        guard let specie1 = specie?.results else {return }
        
        let _ = specie1.map{self.specieArr.append($0)}
        guard let nextLoad = specie?.next else {
            self.tableView.reloadData()
            return
        }
        self.loadAllSpecies(curr: nextLoad)
    }
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
}

typealias TableViewFunctions4 = SixthViewController
extension SixthViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specieArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "specieCell") as? CustomSpecieCell else {
            fatalError("No cell in tableView")
        }
        cell.setPlaceholder()
        cell.loadSpecieImage(fromName: specieArr[indexPath.row].name.replacingOccurrences(of: " ", with: "").folding(options: .diacriticInsensitive, locale: .current))
        cell.myName.text = specieArr[indexPath.row].name
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
