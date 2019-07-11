//
//  LocationTableViewController.swift
//  dressForTheWeather
//
//  Created by Leeann Drees on 7/10/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {

    private let userLocationManager = UserLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedLocationNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        let locationName = "\(storedLocationNames[indexPath.row].city), \(storedLocationNames[indexPath.row].state)"
        cell.textLabel?.text = locationName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        userLocationManager.stopLocating()
        
    }

}
