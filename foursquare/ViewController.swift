//
//  ViewController.swift
//  foursquare
//
//  Created by khlebtsov alexey on 14/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

/*
 https://api.foursquare.com/v2/venues/search?ll=40.7,-74&client_id=P0YNPCXRE0XEKB2CFMO3YWSPRH4UJX23EAD1HAGCDYVKAZGS&client_secret=RZUPVJ1A1WHMDMPUI5FIXWK0HPIRDE5WFCTIGUBQ2ZRYMYRH&v=20131016
 */

import UIKit
import CoreLocation
import MapKit
import Foundation

protocol ViewControllerDelegate{
    func annotationSelected(annotation: PlaceAnnotation)
}

class ViewController: UIViewController {
    
    
    var delegate: ViewControllerDelegate?
    
    var currentLocation: CLLocation?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let venuesTableViewController = AppDelegate.sharedInstance.venuesTableViewController
        venuesTableViewController.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reposition", style: .Plain, target: self, action: #selector(repositionTapped))
        
        mapView.delegate = self
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    let regionRadius: CLLocationDistance = 1000 //1km
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func repositionTapped(sender: UIBarButtonItem){
        AppDelegate.sharedInstance.locationManager.requestLocation()
    }
    
}




extension ViewController:MKMapViewDelegate{
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PlaceAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
                
            }
            return view
        }
        return nil
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let placeAnnotation = view.annotation as? PlaceAnnotation{
            self.navigationController?.popViewControllerAnimated(true)
            self.delegate?.annotationSelected(placeAnnotation)
        }
    }
}

extension ViewController: VenuesTableViewControllerDelegate{
    
    func venuesLoaded(venues: [Venue], forLocation location: CLLocation) {
        
        currentLocation = location
        
        var newAnnotations = [PlaceAnnotation]()
        for venue in venues{
            let artwork = PlaceAnnotation(title: venue.name,
                                          locationName: venue.location.address,
                                          coordinate: venue.location.coordinate)
            newAnnotations.append(artwork)
        }
        
        self.performOnMainThread({
            let annotationsToRemove = self.mapView.annotations.filter { $0 !== location }
            self.mapView.removeAnnotations( annotationsToRemove )
            self.mapView.addAnnotations(newAnnotations)
            self.centerMapOnLocation(location)
        })
    }
    
    func venueSelected(venue: Venue) {
        let annotations = self.mapView.annotations.filter { $0.coordinate.latitude == venue.location.coordinate.latitude && $0.coordinate.longitude == venue.location.coordinate.longitude}
        if annotations.count>0{ //found
            let annotation = annotations[0]
            if let annotationView = self.mapView.viewForAnnotation(annotation){
                annotationView.highlight()
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }
    }
    
}



