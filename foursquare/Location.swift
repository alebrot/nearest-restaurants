//
//  Location.swift
//  foursquare
//
//  Created by khlebtsov alexey on 14/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    var coordinate: CLLocationCoordinate2D
    var address: String
    init(coordinate:CLLocationCoordinate2D, address: String){
        self.address = address
        self.coordinate = coordinate
    }
}