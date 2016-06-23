//
//  PlaceAnnotation.swift
//  foursquare
//
//  Created by khlebtsov alexey on 16/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class PlaceAnnotation: NSObject, MKAnnotation {
    let title: String?
    var subtitle: String? {
        return locationName
    }
    let coordinate: CLLocationCoordinate2D
    
    
    let locationName: String

    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
}