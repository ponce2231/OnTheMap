//
//  LocationsListTableVC.swift
//  OnTheMap
//
//  Created by Christopher Ponce Mendez on 9/28/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class LocationsListTableVC: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocationsOnTable()
    }
    

    @IBAction func refreshWasTapped(_ sender: Any) {
        getLocationsOnTable()
    }
    
    @IBAction func logoutWasTapped(_ sender: Any) {
        UdacityClient.deleteSession {_,_ in
                DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }

    }
    func logoutHandler(success: Bool, error: Error?){
        if success {
            print("user has logout")
        }else{
            print(error?.localizedDescription)
        }
    }
    func getLocationsOnTable(){
        _ = ONTMClient.getStudentsLocations(completionHandler: { (location, error) in
             LocationsData.locations = location
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LocationsData.locations.count
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let urlString = LocationsData.locations[indexPath.row]
    if let url = URL(string: urlString.mediaURL)
        {
            UIApplication.shared.open(url)
        }
            tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            
        let locationData = LocationsData.locations[indexPath.row]
        print(locationData.firstName)
        cell.textLabel?.text = locationData.firstName + " " + locationData.lastName
        cell.detailTextLabel?.text = locationData.mediaURL
        

        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
