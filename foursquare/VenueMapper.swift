//
//  VenueMapper.swift
//  foursquare
//
//  Created by khlebtsov alexey on 14/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import Foundation

class VenueMapper: BaseMapper<Venue> {
    
    private static let responseKey = "response"
    private static let venuesKey =  "venues"
    
    static let idKey = "id"
    static let nameKey = "name"
    static let locationKey = "location"
    
    override class func createObjectFrom(dictionary: Dictionary<String, AnyObject> ) -> Venue?{
        
        if let id = dictionary[idKey] as? String{
            if let name =  dictionary[ nameKey ] as? String{
                if let locationDict =  dictionary[ locationKey ] as? Dictionary<String, AnyObject>{
                    if let location = LocationMapper.createObjectFrom(locationDict){
                        return Venue(id: id, name: name, location: location)
                    }
                }
            }
        }
        
        return super.createObjectFrom(dictionary)
    }
    
    override class func getRoot(dictionary: Dictionary<String, AnyObject> ) -> AnyObject?{
        if let dataDict = dictionary[responseKey]  as? Dictionary<String, AnyObject>{
            if let arrayDict = dataDict[venuesKey] as? NSArray {
                return arrayDict
            }
        }
        return super.getRoot(dictionary)
    }
}