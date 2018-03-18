//
//  ViewController.swift
//  TravellerTrips
//
//  Created by Jerdon Helgeson on 1/21/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    //In the ViewController class, create two properties: “trips” which is an initially empty array of Trip objects, and “tripIndex” which is an integer initially zero.
    var globalCounter = 0;
    var trips = [Trips]();
    var tripIndex: Int = 0;
    
    
    @IBOutlet weak var Destination: UITextField!
    @IBOutlet weak var StartDate: UITextField!
    @IBOutlet weak var EndDate: UITextField!
    @IBOutlet weak var NewDestination: UITextField!
    @IBOutlet weak var NewStartDate: UITextField!
    @IBOutlet weak var NewEndDate: UITextField!
    @IBOutlet weak var errorMessage: UITextField!
    @IBOutlet weak var ImTheImageDawg: UIImageView!
    @IBOutlet weak var tripsCounter: UILabel!
    
    
    @IBAction func Save(_ sender: Any) {
        //Do get dates and check format
        let formatter = DateFormatter();
        formatter.dateFormat = "MM/dd/yyyy";
        let stTemp = NewStartDate.text;
        let enTemp = NewEndDate.text;
        let stDate = formatter.date(from: stTemp!);
        let enDate = formatter.date(from: enTemp!);
        var bueno = true
        var error = ""
        if(stDate == nil || enDate == nil)
        {
            if(stDate == nil && enDate == nil)
            {error = error + " incorrect Start and End Date Format; "}
            else
            {
                if(stDate == nil){error = error + " Invalid Start Date; "}
                else{error = error + " Invalid End Date; "}
            }
            bueno = false
        }
        if(NewDestination.text == "")
        {
            bueno = false
            error = error + " Missing Destination; ";
            
        }
        if(bueno == true)
        {//no errors found
            errorMessage.text = "";
            //append the new destination to the list of destinations
            let newTrip = Trips(destinationName: NewDestination.text!, startDate: stDate!, endDate: enDate!)
            trips.append(newTrip)
            NewDestination.text = ""
            NewStartDate.text = ""
            NewEndDate.text = ""
        }
        else{errorMessage.text = error;}
        
    }
    
   
    
    
    @IBAction func AddNewTrip(_ sender: Any)
    {
        
        
        
    }
    
    
    @IBAction func Next(_ sender: Any) {
        
        displayTrip(gCounter: globalCounter)
        
        let i = trips.count - 1;
        var tripsCounterStr = "Trip: " + String(globalCounter + 1) + " of " + String(trips.count);
        if(globalCounter < i)
        {
            globalCounter = globalCounter+1;
            tripsCounterStr = "Trip: " + String(globalCounter) + " of " + String(trips.count);
        }
        else{
            tripsCounterStr = "Trip: " + String(globalCounter + 1) + " of " + String(trips.count);
            globalCounter = 0;
        }
        tripsCounter.text = tripsCounterStr;
    }
    
    
    //let dateFormatter = DateFormatter();
    //dateFormatter.dateFormat = "MM/dd/yyyy"
    //let today = Date()
    func initializeTrips()
    {
        //Date Stuff
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
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
    
    func displayTrip(gCounter : Int)
    {
        
        let dest = "Destination: "
        let st = "Start Date: "
        let en = "End Date: "
        //if(Destination.text == dest+place.destinationName) //if you've found the current do next
        Destination.text = dest + trips[gCounter].destinationName
        StartDate.text = st + (trips[gCounter].startDate).toString() //"Some Date"//can't just cast to string.
        EndDate.text = en + (trips[gCounter].endDate).toString()
        if(trips[gCounter].imageFileName != nil)
        {
            let img = UIImage(named : trips[gCounter].imageFileName!)
            ImTheImageDawg.image = img
        }
        else{ImTheImageDawg.image = nil}
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(trips.count == 0)
        {initializeTrips()}
        var trs = "Trip: " + String(globalCounter) + " of " + String(trips.count);
        tripsCounter.text = trs
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var addTripController = segue.destination as! AddTripViewController
        addTripController.globalCounter = globalCounter;
        addTripController.trips = trips;
    }


}

