//
//  GameClass.swift
//  479FinalProject
//
//  Created by Jerdon Helgeson on 4/5/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

//import Foundation
import UIKit


extension Date
{
    func toString() -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YYYY"
        return dateFormatter.string(from: self)
    }
}

class game
{
    //Properties
    var gameName: String
    var imageFileName: String? // imageFileName is an optional as denoted by the questionMark //this means that imageFileName may or maynot be of string type. To unwrap an imageFileName you must simply put an exclamation point inFront of it
    var rating: Double
    var gameType: String
    var classic: Bool
    var indoor: Bool
    var outdoor: Bool
    var materials: String
    var minPlayers: Int
    var maxPlayers: Int
    var rules: String
    var alternateNames: String
    
    
    
    
    
    // imageFileName is an optional as denoted by the questionMark //this means that imageFileName may or maynot be of string type. To unwrap an imageFileName you must simply put an exclamation point inFront of it
    
    
    
    //Methods
    
    //Constructors (init)
    init (gameName: String)
    {
        self.gameName = gameName;
        self.imageFileName = "";
        self.classic = false;
        self.rating = 5;
        self.gameType = "";
        self.indoor = false;
        self.outdoor = false;
        self.materials = "";
        self.minPlayers = 0
        self.maxPlayers = 0
        self.rules = ""
        self.alternateNames = "None"
    }
    
    init (gameName: String,imageFileName:String ,classic: Bool, rating: Double, gameType: String, indoor: Bool, outdoor:Bool, materials:String,minPlayers:Int,maxPlayers:Int,rules:String,alternateNames:String)
    {
        self.gameName = gameName;
        self.imageFileName = imageFileName;
        self.classic = classic;
        self.rating = rating;
        self.gameType = gameType;
        self.indoor = indoor;
        self.outdoor = outdoor;
        self.materials = materials;
        self.minPlayers = minPlayers;
        self.maxPlayers = maxPlayers;
        self.rules = rules;
        self.alternateNames = alternateNames;
    }
}

