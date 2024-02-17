//
//  BannerMovie.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 12.02.2024.
//

import Foundation
import SwiftyJSON

class BannerMovie{
    var id = 0
    var link = ""
    var movie: Movie = Movie()
    
    init(){
        
    }
    
    init(json: JSON){
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["link"].string {
            self.link = temp
        }
        if json["movie"].exists() {
            movie = Movie(json: json["movie"])
        }
    }
    
}
