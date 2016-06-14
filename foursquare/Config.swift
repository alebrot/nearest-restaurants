//
//  Config.swift
//  foursquare
//
//  Created by khlebtsov alexey on 14/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import Foundation


struct Config {
    struct FoursquareAPI {
        static let clientId = CommonUtilities.getStringFromMainBundle("ClientId")!
        static let clientSecret = CommonUtilities.getStringFromMainBundle("ClientSecret")!
        static let baseUrl = CommonUtilities.getStringFromMainBundle("BaseUrl")!
        static let version = CommonUtilities.getStringFromMainBundle("FoursquareAPIVersion")!
    }
}