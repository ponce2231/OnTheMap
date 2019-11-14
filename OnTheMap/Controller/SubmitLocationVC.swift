//
//  SubmitLocationVC.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 11/7/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import MapKit

class SubmitLocationVC: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    var locationString: String?
    var siteString: String?
     let annotation = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()

        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: self.mapView.userLocation.coordinate.latitude, longitude: self.mapView.userLocation.coordinate.longitude)
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = locationString
        searchRequest.region = region
        let search = MKLocalSearch(request: searchRequest)

        search.start { (response, error) in
            //check error is nil
            if error != nil{
                return
            }
            //if its not check your response (count)
            if (response?.mapItems.count) != 0 {
                self.annotation.coordinate = CLLocationCoordinate2D(latitude: (response?.mapItems[0].placemark.coordinate.latitude)!, longitude: (response?.mapItems[0].placemark.coordinate.longitude)!)
                self.annotation.title = self.locationString
                self.annotation.subtitle = self.siteString
                self.mapView.addAnnotation(self.annotation)
                
            }
            else{
                print(error?.localizedDescription)
            }

        }
            
    }
    
    @IBAction func finishButtonPressed(_ sender: Any) {
        ONTMClient.postStudentLocation(firstName: "chris", lastName: "po", country: self.locationString! , linkedInString: siteString!, xAxis: self.annotation.coordinate.latitude, yAxis: self.annotation.coordinate.longitude, completionHandler: postLocationHandler(success:error:))
    }
    
    func postLocationHandler(success: Bool, error: Error?){
        if success{
            print("Post was a success")
        }else{
            print(error?.localizedDescription)
        }
    }
    
    //MARK: -Delegate functions
    
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
                app.open(URL(string: toOpen)!)
            }
        }
    }
}
