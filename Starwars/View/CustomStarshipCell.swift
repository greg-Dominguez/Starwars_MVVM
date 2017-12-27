//
//  CustomStarshipCell.swift
//  Starwars
//
//  Created by Admin on 12/25/17.
//  Copyright © 2017 Greg Dominguez. All rights reserved.
//

import UIKit


class CustomStarshipCell: UITableViewCell{
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myName: UILabel!
    
    //check the cache
    func loadStarImage(fromName name:String) {
        if let image = GlobalCache.shared.imgCache.object(forKey:name as NSString){
            self.myImage.image = image
            return
        }
        
        Networking.downloadStarshipImage(byName: name, completion: { (image, error) in
            guard error == nil else {return}
            guard let image = image else{return}
            GlobalCache.shared.imgCache.setObject(image,forKey: name as NSString)
            
            DispatchQueue.main.async {
                self.myImage.image = image
            }
        })
    }
    
    func setPlaceholder(){
        self.myImage.image = #imageLiteral(resourceName: "frog")
    }
}
