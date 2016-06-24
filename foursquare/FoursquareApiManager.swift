//
//  FoursquareApiManager.swift
//  foursquare
//
//  Created by khlebtsov alexey on 24/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import Foundation

struct FoursquareApiManager{
    static let request = FoursquareRequest(baseUrl: Config.FoursquareAPI.baseUrl, clientId: Config.FoursquareAPI.clientId, clientSecret: Config.FoursquareAPI.clientSecret, version: Config.FoursquareAPI.version)
}