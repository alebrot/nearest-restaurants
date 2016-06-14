//
//  NSData.swift
//  foursquare
//
//  Created by khlebtsov alexey on 14/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import Foundation


extension NSData {
    func toDictionary() -> [ String: AnyObject ]? {
        let jsonError: NSError?
        do{
            if let dict = try NSJSONSerialization.JSONObjectWithData(self, options: NSJSONReadingOptions.MutableContainers) as? Dictionary<String, AnyObject> {
                return dict
            }
        }catch let error as NSError {
            jsonError = error
            print(jsonError)
        }
        return nil
    }
}