//
//  MapVC.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 9/28/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocationsOnMap()
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        getLocationsOnMap()
    }
    //MARK: -get the location of the students and mark its possition(pin)
    func getLocationsOnMap() {
                ONTMClient.getStudentsLocations { (locations, error) in
             LocationsData.locations = locations
            var annotations = [MKPointAnnotation]()
            
            for item in locations{
                let lat = CLLocationDegrees(item.latitude)
                let long = CLLocationDegrees(item.longitude)
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let firstName = item.firstName
                let lastName = item.lastName
                let mediaURL = item.mediaURL
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = coordinate
                
                annotation.title = "\(firstName) \(lastName)"
                annotation.subtitle = mediaURL
                
                annotations.append(annotation)
                
            }
            self.mapView.addAnnotations(annotations)
        }
    }
    //MARK: -Delegate Functions
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           
           let reuseId = "pin"
           
           var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

           if pinView == nil {
               pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
               pinView!.canShowCallout = true
               pinView!.pinTintColor = .red
               pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
           }
           else {
               pinView!.annotation = annotation
           }
           
           return pinView
       }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
}
