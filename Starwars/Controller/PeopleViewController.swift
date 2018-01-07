//
//  ViewController.swift
//  Starwars
//
//  Created by Admin on 12/24/17.
//  Copyright © 2017 Greg Dominguez. All rights reserved.
//
import Alamofire
import UIKit

//enum for segue parameter 

class FirstViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var peopleArr = [Person]()
    var personGo:Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("in first view did load")
        loadAllPeople(curr: "https://swapi.co/api/people")        
    }
    
    
    func loadAllPeople(curr:String){
        Networking.getPeople(byPage: curr) {
            [unowned self](people, error) in
            print("we are outside")
            //TODO: Account for error cases
            guard error == nil else{
                print(error!)
                return
            }
            guard let people1 = people?.results else {return }

            let _ = people1.map{self.peopleArr.append($0)}
            guard let nextLoad = people?.next else {
                self.tableView.reloadData()
                return
            }
            self.loadAllPeople(curr: nextLoad)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.personGo = peopleArr[indexPath.row]
        performSegue(withIdentifier: "personToDetails", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else {return}
//        guard let indexPath = self.tableView.indexPathForSelectedRow else{return}
//        detailVC.person = self.peopleArr[indexPath.row]
        detailVC.person = self.personGo

    }
}

typealias TableViewFunctions = FirstViewController

extension TableViewFunctions: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell") as? CustomPeopleCell else {
            fatalError("No cell in tableView")
        }
//        cell.textLabel?.text = peopleArr[indexPath.row].name
        cell.setPlaceholder()
        cell.loadPersonImage(fromName: peopleArr[indexPath.row].name.replacingOccurrences(of: " ", with: "").folding(options: .diacriticInsensitive, locale: .current))
        cell.myName.text = peopleArr[indexPath.row].name
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Character List - People"
    }
}

