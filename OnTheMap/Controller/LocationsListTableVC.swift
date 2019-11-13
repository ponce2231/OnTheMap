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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocationsOnTable()
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
// pasar la informacion de los locations a la celda como en the movie manager
    
    
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
