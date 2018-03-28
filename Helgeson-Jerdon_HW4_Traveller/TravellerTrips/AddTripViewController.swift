//
//  AddTripViewController.swift
//  TravellerTrips
//
//  Created by Jerdon Helgeson on 2/6/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController {

    var trips = [Trips]();
    var globalCounter = 0;
    var doSegue = false;
    
    @IBOutlet weak var TripsLabel: UILabel!
    @IBOutlet weak var Destination: UITextField!
    @IBOutlet weak var StartDate: UITextField!
    @IBOutlet weak var EndDate: UITextField!
    @IBOutlet weak var ErrorMessage: UITextField!
    
    
    
    
    
    
    @IBAction func Save(_ sender: Any) {
        //can reuse code from other view controller here
        //if it doesn't fail
        let formatter = DateFormatter();
        formatter.dateFormat = "MM/dd/yyyy";
        let stTemp = StartDate.text;
        let enTemp = EndDate.text;
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
        if(Destination.text == "")
        {
            bueno = false
            error = error + " Missing Destination; ";
            
        }
        if(bueno == true)
        {//no errors found
            ErrorMessage.text = "";
            //append the new destination to the list of destinations
            let newTrip = Trips(destinationName: Destination.text!, startDate: stDate!, endDate: enDate!)
            trips.append(newTrip)
            Destination.text = ""
            StartDate.text = ""
            EndDate.text = ""
            TripsLabel.text = "Add New Trip #" + String(trips.count + 1)
            doSegue = true;
        }
        else{ErrorMessage.text = error;}
        //must check if fields are correct before segue occurs

    }
    
    
    
    @IBAction func Cancel(_ sender: Any) {
        Destination.text = ""
        StartDate.text = ""
        EndDate.text = ""
        doSegue = true
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TripsLabel.text = "Add New Trip #" + String(trips.count + 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var viewController = segue.destination as! ViewController;
        viewController.trips = trips
    
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(doSegue == true)
        {return true;}
        else{return false;}
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
