//
//  Venue.swift
//  foursquare
//
//  Created by khlebtsov alexey on 14/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import Foundation

class Venue {
    var id: String
    var name:String
    var location: Location
    init(id: String, name: String, location: Location){
        self.id = id
        self.name = name
        self.location = location
    }
}