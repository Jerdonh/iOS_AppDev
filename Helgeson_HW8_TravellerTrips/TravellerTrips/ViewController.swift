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
    var globalCounter: Int = 0;
    @IBOutlet weak var Destination: UITextField!
    @IBOutlet weak var StartDate: UITextField!
    @IBOutlet weak var EndDate: UITextField!
    
    @IBOutlet weak var ImTheImageDawg: UIImageView!
    
    //STARS
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    
    @IBAction func Next(_ sender: Any) {
        
        //displayTrip(gCounter: globalCounter)
        
        let i = trips.count - 1;
        if(globalCounter < i){globalCounter = globalCounter+1;}
        else{globalCounter = 0;}
        
        displayTrip(gCounter: globalCounter)
        print(globalCounter)
    }
    
    @objc func swiperNoSwiping(swipe: UISwipeGestureRecognizer) //left is false right is true
    {
        
        //displayTrip(gCounter: globalCounter)
        if(swipe.direction == UISwipeGestureRecognizerDirection.left)
        {
            let i = trips.count - 1;
            if(globalCounter < i){globalCounter = globalCounter+1;}
            else{globalCounter = 0;}
        }
        else
        {
            //let i = trips.count - 1;
            if(globalCounter > 0){globalCounter = globalCounter-1;}
            else{globalCounter = 2;}
        }
        print(globalCounter)
        displayTrip(gCounter: globalCounter)
        
    }
    
    var trips = [Trips]();
    var tripIndex: Int = 0;
    //let dateFormatter = DateFormatter();
    //dateFormatter.dateFormat = "MM/dd/yyyy"
    //let today = Date()
    //var rating = 0;
    
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
        let img = UIImage(named : trips[gCounter].imageFileName!)
        ImTheImageDawg.image = img
        
        let tempRating = trips[gCounter].rating;
        let sStar = UIImage(named : "SilverStar.jpeg")
        let gStar = UIImage(named : "goldStar.jpeg")
        
        if(tempRating == 0)
        {
            //all silver
            star1.image = sStar; star2.image = sStar; star3.image = sStar; star4.image = sStar; star5.image = sStar;
            
        }
        else if(tempRating == 1)
        {
            star1.image = gStar; star2.image = sStar; star3.image = sStar; star4.image = sStar; star5.image = sStar;
        }
        else if(tempRating == 2)
        {
            star1.image = gStar; star2.image = gStar; star3.image = sStar; star4.image = sStar; star5.image = sStar;
        }
        else if(tempRating == 3)
        {
            star1.image = gStar; star2.image = gStar; star3.image = gStar; star4.image = sStar; star5.image = sStar;
        }
        else if(tempRating == 4)
        {
            star1.image = gStar; star2.image = gStar; star3.image = gStar; star4.image = gStar; star5.image = sStar;
        }
        else{star1.image = gStar; star2.image = gStar; star3.image = gStar; star4.image = gStar; star5.image = gStar;}
        
        
    }
    
    //TODO: FIX GLOBALCOUNTER ISSUE
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let sStar = UIImage(named : "SilverStar.jpeg")
        let gStar = UIImage(named : "goldStar.jpeg")
        var gFixer = globalCounter; if(gFixer > 2){gFixer = 0};if(gFixer < 0){gFixer = 2;}
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if(tappedImage == star1)
        {
            star1.image = gStar; star2.image = sStar; star3.image = sStar; star4.image = sStar; star5.image = sStar;
            //set star1 gold and rating = 1
            trips[gFixer].rating = 1
        }
        else if(tappedImage == star2)
        {
            star1.image = gStar; star2.image = gStar; star3.image = sStar; star4.image = sStar; star5.image = sStar;
            //set star1 & 2 gold and rating = 2
            trips[gFixer].rating = 2
        }
        else if(tappedImage == star3)
        {
            star1.image = gStar; star2.image = gStar; star3.image = gStar; star4.image = sStar; star5.image = sStar;
            //set star1,2,3 gold and rating = 3
            trips[gFixer].rating = 3
        }
        else if(tappedImage == star4)
        {
            star1.image = gStar; star2.image = gStar; star3.image = gStar; star4.image = gStar; star5.image = sStar;
            //set star1,2,3,4 gold and rating = 4
            trips[gFixer].rating = 4
        }
        else if(tappedImage == star5)
        {
            star1.image = gStar; star2.image = gStar; star3.image = gStar; star4.image = gStar; star5.image = gStar;
            //set star1,2,3,4,5 gold and rating = 5
            trips[gFixer].rating = 5
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeTrips()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swiperNoSwiping(swipe:)));
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right;
        self.view.addGestureRecognizer(rightSwipe);
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swiperNoSwiping(swipe:)));
         rightSwipe.direction = UISwipeGestureRecognizerDirection.left;
        self.view.addGestureRecognizer(leftSwipe);
        
        let tapGestureReconizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)));
        let tapGestureReconizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)));
        let tapGestureReconizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)));
        let tapGestureReconizer4 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)));
        let tapGestureReconizer5 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)));
        star1.isUserInteractionEnabled = true;
        star1.addGestureRecognizer(tapGestureReconizer1);
        star2.isUserInteractionEnabled = true;
        star2.addGestureRecognizer(tapGestureReconizer2);
        star3.isUserInteractionEnabled = true;
        star3.addGestureRecognizer(tapGestureReconizer3);
        star4.isUserInteractionEnabled = true;
        star4.addGestureRecognizer(tapGestureReconizer4);
        star5.isUserInteractionEnabled = true;
        star5.addGestureRecognizer(tapGestureReconizer5);
        
        //globalCounter = 0;
        displayTrip(gCounter: globalCounter);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

