//
//  TableView_ViewController.swift
//  TravellerTrips
//
//  Created by Jerdon Helgeson on 2/13/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit


class TableView_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    var trips = [Trips]();
    var showTrip = Trips(destinationName: "", startDate: Date(), endDate: Date());
    var selectIndex = 0;
    var tripSelected = false;
    var isShowSegue = false;
    
    @IBAction func toAddTrip(_ sender: Any) {
       
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripSelected = false;
        if(trips.count == 0)
        {initializeTrips()}
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trips.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell") as! TableViewCell;
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell;
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy";
        
        if(trips[indexPath.row].imageFileName != nil)
        {let img = UIImage(named : trips[indexPath.row].imageFileName!)
        cell.myImage.image = img }//UIImage(named:(trips[indexPath.row].imageFileName!))}
        else{cell.myImage.image = nil}
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTrip = trips[indexPath.row];
        tripSelected = true;
        performSegue(withIdentifier: "ShowSegue", sender: self)
    //performSegue(withIdentifier: "ShowSegue", sender: Any?)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier != "ShowSegue"){
        var addTripController = segue.destination as! AddTripViewController
            addTripController.trips = trips;}
        
        else{
        var showTripController = segue.destination as! ViewController
            isShowSegue = true;
            showTripController.showTrip = showTrip;}
    
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        if(identifier == "ShowSegue")
        {
            if(tripSelected == false)
            {return false}
        }
        return true
    }





}



/*

class TableView_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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

 */
