//
//  LocationMapper.swift
//  foursquare
//
//  Created by khlebtsov alexey on 14/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import Foundation
import CoreLocation

class LocationMapper: BaseMapper<Location> {
    
    private static let latKey = "lat"
    private static let lngKey = "lng"
    private static let formattedAddressKey = "formattedAddress"
    
    
    override class func createObjectFrom(dictionary: Dictionary<String, AnyObject> ) -> Location?{
        
        if let lat = dictionary[latKey] as? CLLocationDegrees{
            if let lng = dictionary[lngKey] as? CLLocationDegrees{
                if let formattedAddressArray =  dictionary [ formattedAddressKey ] as? NSArray{
                    let address = formattedAddressArray.componentsJoinedByString(", ")
                    return Location(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng), address: address )
                }
            }
        }
        
        return super.createObjectFrom(dictionary)
    }
}