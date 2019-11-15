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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var finishButton: UIButton!
    
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
                self.setLocation(true)
                self.showLocationAlert(message: "Location NOT FOUND!" )
                return
            }
            
            //if its not check your response (count)
            if (response?.mapItems.isEmpty == true){
                self.setLocation(true)
                self.showLocationAlert(message: "Location NOT FOUND!")
            }else{
                   self.setLocation(true)
                   self.annotation.coordinate = CLLocationCoordinate2D(latitude: (response?.mapItems[0].placemark.coordinate.latitude)!, longitude: (response?.mapItems[0].placemark.coordinate.longitude)!)
                   self.annotation.title = self.locationString
                   self.annotation.subtitle = self.siteString
                   self.mapView.addAnnotation(self.annotation)
                    self.setLocation(false)
                
                 }
        }
            
    }
    
    func postLocationHandler(success: Bool, error: Error?){
        setLocation(false)
        if success{
            print("Post was a success")
            self.dismiss(animated: true, completion: nil)
        }else{
            self.showLocationAlert(message: error!.localizedDescription)
        }
    }
    
    func showLocationAlert(message: String){
        let locationAlertVC = UIAlertController(title: "Location error Alert", message: message, preferredStyle: .alert)
        locationAlertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(locationAlertVC,sender: nil)
    }
    
    func setLocation(_ locating: Bool) {
        if locating{
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
            
        }else{
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
        DispatchQueue.main.async {
            self.finishButton.isEnabled = !locating
        }
    }
    @IBAction func finishButtonPressed(_ sender: Any) {
        ONTMClient.postStudentLocation(firstName: "chris", lastName: "po", country: self.locationString! , linkedInString: siteString!, xAxis: self.annotation.coordinate.latitude, yAxis: self.annotation.coordinate.longitude, completionHandler: postLocationHandler(success:error:))
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
