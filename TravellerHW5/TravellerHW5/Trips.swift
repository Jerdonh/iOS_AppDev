//
//  Trips.swift
//  TravellerHW5
//
//  Created by Jerdon Helgeson on 2/13/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

//
//  Trip.swift
//  TravellerTrips
//
//  Created by Jerdon Helgeson on 1/21/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import Foundation

extension Date
{
    func toString() -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YYYY"
        return dateFormatter.string(from: self)
    }
}

class Trips
{
    //Properties
    var destinationName: String
    var startDate: Date
    var endDate: Date
    var imageFileName: String? // imageFileName is an optional as denoted by the questionMark //this means that imageFileName may or maynot be of string type. To unwrap an imageFileName you must simply put an exclamation point inFront of it
    
    
    
    //Methods
    
    //Constructors (init)
    init (destinationName: String, startDate: Date, endDate: Date)
    {
        self.destinationName = destinationName
        self.startDate = startDate
        self.endDate = endDate
    }
}

