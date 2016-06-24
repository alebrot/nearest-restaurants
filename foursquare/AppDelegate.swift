//
//  AppDelegate.swift
//  foursquare
//
//  Created by khlebtsov alexey on 14/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let sharedInstance = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    
    static let locationUpdatedNotification = "locationUpdatedNotification"
    static let locationUpdatedNotificationKey = "locationUpdatedNotificationKey"
    
    var locationManager: CLLocationManager!
    
    var window: UIWindow?
    
    
    var rootViewController: UISplitViewController!
    
    var venuesTableViewController: VenuesTableViewController{
        let nvc = rootViewController.viewControllers[0] as! UINavigationController
        return nvc.viewControllers[0] as! VenuesTableViewController
    }
    
    var mapViewController: MapViewController{
        return rootViewController.viewControllers[1] as! MapViewController
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.rootViewController = self.window!.rootViewController as! UISplitViewController
        
        //splitViewController.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible;
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

extension AppDelegate:CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            NSNotificationCenter.defaultCenter().postNotificationName(
                AppDelegate.locationUpdatedNotification,
                object: nil,
                userInfo: [AppDelegate.locationUpdatedNotificationKey : location]
            )
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
}
