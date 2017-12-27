//
//  Planets.swift
//  Starwars
//
//  Created by Admin on 12/24/17.
//  Copyright © 2017 Greg Dominguez. All rights reserved.
//

import Foundation


struct Planets:Codable{
    var count:Int
    var next: String?
    var previous:String?
    var results: [Planet]
}

struct Planet:Codable{
    var name:String
    var rotation_period:String
    var orbital_period:String
    var diameter:String
    var climate:String
    var gravity:String
    var terrain:String
    var surface_water:String
    var population:String
    var residents:[String]
    var films:[String]
    var created:String
    var edited:String
    var url:String
}
