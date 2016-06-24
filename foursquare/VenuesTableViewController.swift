//
//  VenuesTableViewController.swift
//  foursquare
//
//  Created by khlebtsov alexey on 16/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import UIKit
import CoreLocation

protocol VenuesTableViewControllerDelegate{
    func venuesLoaded(venues: [Venue], forLocation location: CLLocation)
    func venueSelected(venue: Venue)
}

class VenuesTableViewController: UITableViewController {
    
    var delegate: VenuesTableViewControllerDelegate?
    
    var venues = [Venue]()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VenuesTableViewController.locationUpdatedNotificationReceived(_:)), name: AppDelegate.locationUpdatedNotification, object: nil)
        AppDelegate.sharedInstance.mapViewController.delegate = self
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: AppDelegate.locationUpdatedNotification, object: nil)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Config.TableView.CellIdentifiers.VenueCell, forIndexPath: indexPath) as! VenueCell
        let venue = self.venues[indexPath.row]
        cell.nameLabel.text = venue.name
        cell.locationLabel.text = venue.location.address
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let venue = self.venues[indexPath.row]
        if let detailViewController = self.delegate as? MapViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
        self.delegate?.venueSelected(venue)
    }
    
    func load(){
        if let location = currentLocation{
            FoursquareApiManager.request.getVenuesSearch(location.coordinate , limit: Config.TableView.listLoadLimit, offset: 0) { (ok: Bool, objects: [Venue]?, error: NSError?) in
                
                if objects != nil{
                    self.delegate?.venuesLoaded(objects!, forLocation: location)
                    
                    self.performOnMainThread({
                        self.venues = objects!
                        self.tableView.reloadData()
                    })
                }
                
                
            }
        }
    }
    
    func locationUpdatedNotificationReceived(notification: NSNotification) {
        if let userInfoDict = notification.userInfo as? Dictionary<String, AnyObject> {
            if let location = userInfoDict[ AppDelegate.locationUpdatedNotificationKey ] as? CLLocation {
                currentLocation = location
                self.load()
            }
        }
    }
    
}

extension VenuesTableViewController: MapViewControllerDelegate{
    func annotationSelected(annotation: PlaceAnnotation) {
        for (index, venue) in venues.enumerate() {
            if(venue.location.coordinate.latitude == annotation.coordinate.latitude && venue.location.coordinate.longitude == annotation.coordinate.longitude){
                self.performOnMainThread({
                    self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Top)
                })
                return
            }
        }
    }
}
