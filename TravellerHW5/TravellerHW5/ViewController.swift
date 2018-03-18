//
//  ViewController.swift
//  TravellerHW5
//
//  Created by Jerdon Helgeson on 2/13/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //properties
    var trips = [Trips]();
    
    
    //methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTrips();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trips.count;
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell;
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy";
        
        let img = UIImage(named : trips[indexPath.row].imageFileName!)
        cell.myImage.image = img//UIImage(named:(trips[indexPath.row].imageFileName!))
        cell.myDestination.text = trips[indexPath.row].destinationName
        
        cell.myDates.text = formatter.string(from:(trips[indexPath.row].startDate)) + "-" + formatter.string(from: (trips[indexPath.row].endDate))
        // Configure the cell...
        
        return cell
    }

    
    func initializeTrips()
    {
        //Date Stuff
        var formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy";
        let someDate = formatter.date(from: "01/01/1901")
        let today = Date()
        let yesterday = Date() - 86400
        let theDistantFuture = Date() + 86400
        var testTrip = Trips(destinationName: "Pullman", startDate: yesterday, endDate: today)
        testTrip.imageFileName = "Pullman.jpg"
        var trip1 = Trips(destinationName: "Moscow", startDate: someDate!, endDate: yesterday)
        trip1.imageFileName = "Moscow.jpg"
        var trip2 = Trips(destinationName: "Seattle", startDate: today, endDate: theDistantFuture)
        trip2.imageFileName = "seattle.jpg"
        trips.append(testTrip)
        trips.append(trip1)
        trips.append(trip2)
    }


}

