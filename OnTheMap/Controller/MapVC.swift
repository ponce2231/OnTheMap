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
        ONTMClient.getStudentsLocations(completionHandler: getLocationHandler(success:error:))
        
        ONTMClient.postStudentLocation(firstName: "chris", lastName: "po", country: "moscow, russia", linkedInString: "www.udacity.com", xAxis: 55.634649, yAxis: 37.526635, completionHandler: postLocationHandler(success:error:))
        ONTMClient.putStudentLocation(firstName: "chris", lastName: "po", country: "moscow, russia", linkedInString: "www.udacity.com", xAxis: 55.634649, yAxis: 37.526635, completionHandler: putLocationHandler(success:error:))
         
        
    }
    func putLocationHandler(success:Bool, error: Error?) {
        if success{
            print("strawberry")
        }else{
            print(error?.localizedDescription)
        }
    }
    
    func postLocationHandler(success:Bool, error: Error?) {
        if success{
            print("kiwii")
        }else{
            print(error?.localizedDescription)
        }
    }
    func getLocationHandler(success:Bool, error: Error?) {
        if success{
            print("got locations")
        }else{
            print(error?.localizedDescription)
        }
    }
}
