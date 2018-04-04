//
//  TableView_ViewController.swift
//  TravellerTrips
//
//  Created by Jerdon Helgeson on 2/13/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit
import CoreData


class TableView_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    var trips = [Trips]();
    var tripsNS = [NSManagedObject]();
    var showTrip = Trips(destinationName: "", startDate: Date(), endDate: Date());
    var selectIndex = 0;
    var tripSelected = false;
    var isShowSegue = false;
    
    @IBAction func toAddTrip(_ sender: Any) {
       
        
    }
    
    func fetchCoreData()
    {
        //here i will retrieve all coreData and use it to populate the trips
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Entity")
        request.returnsObjectsAsFaults = false;
        
        do
        {
            let results = try context.fetch(request)
            if(results.count > 0)
            {
                for r in results as![NSManagedObject]
                {
                    var tempDest: String = "";
                    var tempsDate: Date = Date();
                    var tempeDate: Date = Date();
                 //will populate table here
                    if let destinationName = r.value(forKey: "destinationName") as? String
                    {
                        tempDest = destinationName;
                        
                    }
                    if let startDate = r.value(forKey: "startDate") as? Date
                    {
                        tempsDate = startDate;
                        
                    }
                    if let endDate = r.value(forKey: "endDate") as? Date
                    {
                        tempeDate = endDate
                        
                    }
                    var tempTrip = Trips(destinationName: tempDest, startDate: tempsDate, endDate: tempeDate)
                    trips.append(tempTrip)
                    self.tripsNS.append(r);

                }
                
            }
        }
        catch
        {
            // Error
            print("Error while Fetching CoreData")
        }
    }
    
    func addCoreData( destName: String, sDate:Date, eDate:Date )
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        let newTrip = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: context);
        newTrip.setValue( destName, forKey: "destinationName")
        newTrip.setValue( sDate, forKey: "startDate")
        newTrip.setValue( eDate, forKey: "endDate")
        newTrip.setValue( "", forKey: "imageFileName")
        
        var tempTrip = Trips(destinationName: destName, startDate: sDate, endDate: eDate)
        trips.append(tempTrip)
        //tripsNS.append()
        do
        {
            try context.save()
            print("SAVED")
            tripsNS.append(newTrip)
        }
        catch
        {
            //Process Error
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tripSelected = false;
        if(trips.count == 0)
        {fetchCoreData()}
        //{initializeTrips()}
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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            //here is where i have to call a function that removes the Data for this cell from the dataModel
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            let context = appDelegate.persistentContainer.viewContext;
            //let fetchRequest: NSFetchRequest<String> = Profile.fetchRequest()
            //for r in
            

            //Trips tempTrip2Remove = trips[indexPath.row];
            //if let result = try? context.fetch(fetchRequest) {
            //    for object in result {
            print(tripsNS.count)
            if(tripsNS.count == 0)
            {
                fetchCoreData()
                
            }
            if(tripsNS.count > 0)
            {context.delete(self.tripsNS[indexPath.row])
            
            do
            {
                try context.save();
                self.tripsNS.remove(at: indexPath.row);
                //self.tripsNS.removeAll();
                trips.removeAll();
                self.fetchCoreData();
                tableView.reloadData();
                
                
            }catch{}
             //   }
            //}
            //trips.remove(at: indexPath.row)
            //trips.removeAll()
            //context.delete(<#T##object: NSManagedObject##NSManagedObject#>)
            //tableView.reloadData();
            //self.fetchCoreData()
            }
        }
    }
    
    //
    
    
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
