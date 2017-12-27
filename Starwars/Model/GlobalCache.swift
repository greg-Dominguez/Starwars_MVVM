//
//  GlobalCache.swift
//  Starwars
//
//  Created by Admin on 12/24/17.
//  Copyright © 2017 Greg Dominguez. All rights reserved.
//

import UIKit

class GlobalCache{
    static let shared = GlobalCache()
//    var myImage:UIImage?
    var imgCache = ImageCache()
//    var peopleCache = [Person]()
//    var planetCache = [String:Planet]()
    

}


class ImageCache:NSCache<NSString, UIImage>{
    
    var maxSize = Int.max
    
    override var totalCostLimit:Int {
        get{
            return maxSize
        }
        set {
            maxSize = newValue
        }
    }
}
