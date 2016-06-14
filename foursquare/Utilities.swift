//
//  Utilities.swift
//  foursquare
//
//  Created by khlebtsov alexey on 14/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import Foundation


struct Utilities {
    
}

struct CommonUtilities {
    static func getStringFromMainBundle(key: String) -> String? {
        if let infoPlist = NSBundle.mainBundle().infoDictionary {
            if let apiURL = infoPlist[key] as? String {
                return apiURL
            }
        }
        return nil
    }
    static func getStringFromBundle(filename: String, key: String) -> String? {
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "plist"){
            if let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
                if let value = dict[key] as? String {
                    return value
                }
            }
        }
        
        return nil
    }
}