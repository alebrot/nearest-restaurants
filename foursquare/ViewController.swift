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

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // FoursquareRequest.getVenuesSearch(FoursquareRequest)
        //40.7,-74
        
//mapView.centerCoordinate
        FoursquareApiManager.request.getVenuesSearch(CLLocationCoordinate2D(latitude: 40.7, longitude: -74), limit: 100, offset: 0) { (ok, objects, error) in
            print(objects)
        }
        
        mapView.delegate = self
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController:CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.mapView.setRegion(region, animated: true)
            
            //locationManager.stopUpdatingLocation()
            
            // show artwork on map
            let artwork = PlaceAnnotation(title: "King David Kalakaua",
                                  locationName: "Waikiki Gateway Park",
                                  coordinate: location.coordinate)
            
            mapView.addAnnotation(artwork)
            
            
        }
    }
    
    
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
}
extension ViewController:MKMapViewDelegate{
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let centre = mapView.centerCoordinate;
        print(centre)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PlaceAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
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
            print(placeAnnotation)
        }
  
    }
}

class PlaceAnnotation: NSObject, MKAnnotation {
    let title: String?
    var subtitle: String? {
        return locationName
    }
    let coordinate: CLLocationCoordinate2D

    
    let locationName: String
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
}


