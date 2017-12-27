//
//  Species.swift
//  Starwars
//
//  Created by Admin on 12/24/17.
//  Copyright © 2017 Greg Dominguez. All rights reserved.
//

import Foundation

struct Species:Codable{
    var count:Int
    var next: String?
    var previous:String?
    var results: [Specie]
}

struct Specie:Codable{
    var name:String
    var classification:String
    var designation:String
    var average_height:String
    var skin_colors:String
    var hair_colors:String
    var eye_colors:String
    var average_lifespan:String
    var homeworld:String? //LOL sneaky bastard
    var language:String
    var people: [String]
    var films:[String]
    var created:String
    var edited:String
    var url:String
}

