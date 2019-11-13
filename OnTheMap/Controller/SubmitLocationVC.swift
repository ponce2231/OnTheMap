//
//  SubmitLocationVC.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 11/7/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import MapKit

class SubmitLocationVC: UIViewController,MKMapViewDelegate  {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationString: String?
    var siteString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let savedLocationString = locationString
        let savedSiteString = siteString
        print(savedLocationString ?? "banana")
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: self.mapView.userLocation.coordinate.latitude, longitude: self.mapView.userLocation.coordinate.longitude)
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = savedLocationString
        searchRequest.region = region
        let search = MKLocalSearch(request: searchRequest)
        let annotation = MKPointAnnotation()
        
        search.start { (response, error) in
            //check error is nil
            guard let error = error else{
                return
            }
            //if its not check your response (count)
            if (response?.mapItems.count) != 0 {
                annotation.coordinate = region.center
                annotation.title = self.locationString
                self.mapView.addAnnotation(annotation)
                print(response?.mapItems[0].placemark)
            }else{
                print(error.localizedDescription)
            }
            // if != 0 i will have items to show
            
            print(response?.mapItems[0].placemark)

        }
        

        //        ONTMClient.putStudentLocation(firstName: "chris", lastName: "po", country: "moscow, russia", linkedInString: "www.udacity.com", xAxis: 55.634649, yAxis: 37.526635, completionHandler: putLocationHandler(success:error:))
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func finishButtonPressed(_ sender: Any) {
        ONTMClient.postStudentLocation(firstName: "chris", lastName: "po", country: self.locationString! , linkedInString: siteString!, xAxis: 55.634649, yAxis: 37.526635, completionHandler: postLocationHandler(success:error:))
    }
    
    func postLocationHandler(success: Bool, error: Error?){
        
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
