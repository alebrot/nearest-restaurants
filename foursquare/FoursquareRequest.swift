//
//  FoursquareRequest.swift
//  foursquare
//
//  Created by khlebtsov alexey on 14/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import Foundation
import CoreLocation

class FoursquareRequest {
    
    typealias CompletionHandlerVenues = (ok: Bool, objects: [Venue]?, error: NSError?) -> Void

    
    private let clientId: String
    private let clientSecret: String
    private let baseUrl: String
    private let version: String
    
    private static let clientIdKey = "client_id"
    private static let clientSecretKey = "client_secret"
    private static let versionKey = "v"
    
    private static let locationKey = "ll"
    
    
    private static let limitKey = "limit"
    private static let offsetKey = "offset"
    
    init(baseUrl: String, clientId: String, clientSecret: String, version: String){
        self.baseUrl = baseUrl
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.version = version
    }
    
    func getVenuesSearch(coordinates: CLLocationCoordinate2D, limit: Int, offset: Int, completionHandler: CompletionHandlerVenues){
        var params = getDeafultParams()
        params[FoursquareRequest.limitKey] = limit
        params[FoursquareRequest.offsetKey] = offset
        params[FoursquareRequest.locationKey] = "\(coordinates.latitude),\(coordinates.longitude)"
        
        if let url = NSURL(string:baseUrl+"venues/search")?.URLByAppendingQueryParams(params){
            let request =  NSURLRequest(URL: url)
            getMultipleObjects(request, mapperType: VenueMapper.self, completionHandler: completionHandler)
        }
        
    }
    
    private func getDeafultParams() -> [String: AnyObject]{
        let params: [String: AnyObject] = [FoursquareRequest.clientIdKey: clientId, FoursquareRequest.clientSecretKey: clientSecret, FoursquareRequest.versionKey:version]
        return params
    }
    
    private func getMultipleObjects<T>(request: NSURLRequest, mapperType: BaseMapper<T>.Type, completionHandler: (ok:Bool, objects:[T]?, error:NSError?) -> Void) {
        NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            var objects: [T]?
            var ok = false
            
            if let dictionary = data?.toDictionary(){
                if let dataDict = mapperType.getRoot(dictionary) as? NSArray {
                    objects = mapperType.createArrayFrom(dataDict)
                    ok = (objects != nil)
                }
            }
            
            completionHandler(ok: ok, objects: objects, error: error)
            }.resume()
    }
    
}


struct FoursquareApiManager{
    static let request = FoursquareRequest(baseUrl: Config.FoursquareAPI.baseUrl, clientId: Config.FoursquareAPI.clientId, clientSecret: Config.FoursquareAPI.clientSecret, version: Config.FoursquareAPI.version)
}