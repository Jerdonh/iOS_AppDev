//
//  EncyclopediaTableViewController.swift
//  479FinalProject
//
//  Created by Jerdon Helgeson on 4/6/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit
import CoreData








class EncyclopediaTableViewController: UITableViewController {
    
    var GamesArray = [game]()
    var tempPcolor = ""
    var tempScolor = ""
    var game2Description: game = game(gameName: "")
    var gamesNS = [NSManagedObject]();
    var colrB: UIColor = UIColor.red;
    var colrP: UIColor = UIColor.gray;
    var reducedGames = [game]()
    var fromFinder = false
    
    
    /*
    func populateGamesArray()
    {
        var BP = game(gameName: "Beer Pong")
        GamesArray.append(BP)
        var RC = game(gameName: "Rage Cage")
        GamesArray.append(RC)
        var QTRs = game(gameName: "Quarters")
        GamesArray.append(QTRs)
        var KC = game(gameName: "Kings Cup")
        GamesArray.append(KC)
        var SB = game(gameName: "Slosh Ball")
        GamesArray.append(SB)
        var FC = game(gameName: "Flip Cup")
        GamesArray.append(FC)
        var RtB = game(gameName: "Ride the Bus")
        GamesArray.append(RtB)
        var MSE = game(gameName: "Moose")
        GamesArray.append(MSE)
        var LB = game(gameName: "Ladder Ball")
        GamesArray.append(LB)
        var CH = game(gameName: "Corn Hole")
        GamesArray.append(CH)
        var TWs = game(gameName: "Towers")
        GamesArray.append(TWs)
        var JNGA = game(gameName: "Jenga")
        GamesArray.append(JNGA)
        
    }
 */

    func populateTable() -> game
    {
        let testGame1 = game(gameName: "testGame1");
        
        return testGame1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //populateGamesArray()
        fetchGameData()
        fetchSettingsDataCols()
        sortGamesArray()
        colrB = setCellBorderColor()
        colrP = setCellFillColor()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //retrieve all core data settings info here and load settings on viewdidload
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(fromFinder == false)
        {return GamesArray.count}
        else{return reducedGames.count}
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTableViewCellViewController
        
        if(fromFinder == false)
        {
            // Configure the cell...
            //let testGame1 = populateTable()
            cell.textLabel?.text = GamesArray[indexPath.row].gameName //testGame1.gameName
        
            cell.layer.borderWidth = 2.0
            //print("GamesArray imageFileName: ", GamesArray[indexPath.row].imageFileName!)
            cell.GameImageRealBoi.image = UIImage(named: GamesArray[indexPath.row].imageFileName!)!
            //let colrB = setCellBorderColor()
            //let colrP = setCellFillColor()
            cell.layer.borderColor = colrB.cgColor
            cell.layer.backgroundColor = colrP.cgColor
            
            if(colrB != colrP){cell.textLabel?.textColor = colrB} //case that both colors are unique
            else if(colrP != UIColor.black){cell.textLabel?.textColor = UIColor.black} //case that both colors are the same but not black
            else{cell.textLabel?.textColor = UIColor.magenta}//case that both colors are black
        }
        else // this is the case that it is from the finder
        {
            cell.textLabel?.text = reducedGames[indexPath.row].gameName //testGame1.gameName
            
            cell.layer.borderWidth = 2.0
            //print("GamesArray imageFileName: ", GamesArray[indexPath.row].imageFileName!)
            cell.GameImageRealBoi.image = UIImage(named: reducedGames[indexPath.row].imageFileName!)!
            //let colrB = setCellBorderColor()
            //let colrP = setCellFillColor()
            cell.layer.borderColor = colrB.cgColor
            cell.layer.backgroundColor = colrP.cgColor
            
            if(colrB != colrP){cell.textLabel?.textColor = colrB} //case that both colors are unique
            else if(colrP != UIColor.black){cell.textLabel?.textColor = UIColor.black} //case that both colors are the same but not black
            else{cell.textLabel?.textColor = UIColor.magenta}
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    
    
    
    
    func setCellBorderColor() -> UIColor
    {
        if(tempScolor == "Purple")
        {return UIColor.purple;}
        if(tempScolor == "Red")
        {return UIColor.red;}
        if(tempScolor == "Blue")
        {return UIColor.blue;}
        if(tempScolor == "Black")
        {return UIColor.black;}
        if(tempScolor == "Grey" || tempScolor == "Gray")
        {return UIColor.gray;}
        if(tempScolor == "Green")
        {return UIColor.green;}
        if(tempScolor == "Orange")
        {return UIColor.orange;}
        if(tempScolor == "Yellow")
        {return UIColor.yellow;}
        else{return UIColor.white;}
    }
    
    func setCellFillColor() -> UIColor
    {
        if(tempPcolor == "Purple")
        {return UIColor.purple;}
        if(tempPcolor == "Red")
        {return UIColor.red;}
        if(tempPcolor == "Blue")
        {return UIColor.blue;}
        if(tempPcolor == "Black")
        {return UIColor.black;}
        if(tempPcolor == "Grey" || tempPcolor == "Gray")
        {return UIColor.gray;}
        if(tempPcolor == "Green")
        {return UIColor.green;}
        if(tempPcolor == "Orange")
        {return UIColor.orange;}
        if(tempPcolor == "Yellow")
        {return UIColor.yellow;}
        else{return UIColor.white;}
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        game2Description = GamesArray[indexPath.row]
        
        performSegue(withIdentifier: "EnToGame", sender: self)
    }
    
    
    
    func fetchSettingsDataCols(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Settings")
        request.returnsObjectsAsFaults = false;
        
        
        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        do{
            let results = try context.fetch(request)
            if(results.count > 0)
            {
                for r in results
                {
                    //settingsNS.append(r as! NSManagedObject)
                    if let pC = (r as AnyObject).value(forKey: "primaryColor") as? String
                    {
                        print("fetched Primary Color: ", pC)
                        tempPcolor = pC
                    }
                    if let sC = (r as AnyObject).value(forKey: "secondaryColor") as? String
                    {
                        print("fetched Primary Color: ", sC)
                        tempScolor = sC
                    }
                }
            }
            
        } catch {print("There was a fetch error")}
        
    }
    
    
    func fetchGameData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Game")
        request.returnsObjectsAsFaults = false;
        GamesArray.removeAll()
        
        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        do{
            let results = try context.fetch(request)
            if(results.count > 0)
            {
                
                for r in results
                {
                    gamesNS.append(r as! NSManagedObject)
                    
                    let rName = (r as AnyObject).value(forKey: "gameName") as? String
                    
                    print("fetched game: ", rName!)
                    let rImageFileName = (r as AnyObject).value(forKey: "imageFileName") as? String
                    let rClassic = (r as AnyObject).value(forKey: "classic") as? Bool
                    let rRating = (r as AnyObject).value(forKey: "rating") as? Double
                    let rGameType = (r as AnyObject).value(forKey: "gameType") as? String
                    let rIndoor = (r as AnyObject).value(forKey: "indoor") as? Bool
                    let rOutdoor = (r as AnyObject).value(forKey: "outdoor") as? Bool
                    let rMaterials = (r as AnyObject).value(forKey: "materials") as? String
                    let rMinPlayers = (r as AnyObject).value(forKey: "minPlayers") as? Int
                    let rMaxPlayers = (r as AnyObject).value(forKey: "maxPlayers") as? Int
                    let rRules = (r as AnyObject).value(forKey: "rules") as? String
                    let rAlternateNames = (r as AnyObject).value(forKey: "alternateNames") as? String
                    
                    let tempGame = game(gameName: rName!, imageFileName: rImageFileName!, classic: rClassic!, rating: rRating!, gameType: rGameType!, indoor: rIndoor!, outdoor: rOutdoor!, materials: rMaterials!, minPlayers: rMinPlayers!, maxPlayers: rMaxPlayers!, rules: rRules!, alternateNames: rAlternateNames!)
                    GamesArray.append(tempGame)
                    //
                }
            }
            
        } catch {print("There was a fetch error")}
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "EnToGame")
        {
            let gameName = "Game Name From Encyclopedia"
            let destinationVC = segue.destination as! GameDisplayViewController
            destinationVC.daGame = game2Description;
            destinationVC.gameName = gameName;
        }
    }
    
    func sortGamesArray()
    {
        
        GamesArray.reverse()
        
    }

    
}
