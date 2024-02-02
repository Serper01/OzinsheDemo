//
//  Genre.swift
//  OzinsheDemo
//
//  Created by Serper Kurmanbek on 25.01.2024.
//

import Foundation
import SwiftyJSON

class Genre {
    public var id: Int = 0
    public var name: String = ""
    public var link: String = ""
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["name"].string {
            self.name = temp
        }
        if let temp = json["link"].string {
            self.link = temp
        }
    }
}
