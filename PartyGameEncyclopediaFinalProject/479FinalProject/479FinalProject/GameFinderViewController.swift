//
//  GameFinderViewController.swift
//  479FinalProject
//
//  Created by Jerdon Helgeson on 5/1/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit
import CoreData

class GameFinderViewController: UIViewController {
    @IBOutlet weak var numPlayersLabel: UILabel!
    @IBOutlet weak var materialsAvailableLabel: UILabel!
    @IBOutlet weak var cardsLabel: UILabel!
    @IBOutlet weak var cupsLabel: UILabel!
    @IBOutlet weak var pongLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var settingLabel: UILabel!
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var segment2: UISegmentedControl!
    
    @IBOutlet weak var cardSwitchOutlet: UISwitch!
    @IBOutlet weak var cupSwitchOutlet: UISwitch!
    @IBOutlet weak var pongSwitchOutlet: UISwitch!
    @IBOutlet weak var coinSwitchOutlet: UISwitch!
    
    var numPlayers = 5
    var materials = [String]()
    var settingIn = true
    var settingOut = false
    var GamesArray = [game]()
    var gamesReduced = [game]()
    var gamesNS = [NSManagedObject]();
    var tempPcolor = ""
    var tempScolor = ""
    

    
    
    
    @IBAction func NumPlayersSegment(_ sender: UISegmentedControl) {
        
        let title = segment.titleForSegment(at: segment.selectedSegmentIndex)
        if(title == "2-5")
        {numPlayers = 5}
        else if(title == "6-10")
        {numPlayers = 10}
        else if(title == "11-15")
        {numPlayers = 15}
        else if(title == "16+")
        {numPlayers = 16}
        print(numPlayers," Segment selected")
    }
    
    @IBAction func settingSegment(_ sender: UISegmentedControl) {
        let title = segment2.titleForSegment(at: segment2.selectedSegmentIndex)
        if(title == "Indoors")
        {settingIn = true; settingOut = false}
        else if(title == "Outdoors")
        {settingOut = true; settingIn = false}
        else if(title == "Either")
        {settingIn = true; settingOut = true}
        
        print(title! ," Segment selected")
    }
    
    
 
    @IBAction func cardsSwitch(_ sender: UISwitch) {
        print("cards switched")
        if(cardSwitchOutlet.isOn)
        {
            if(!materials.contains("cards"))
            {
                materials.append("cards")
            }
        }
        else //remove cards
        {
            if(materials.contains("cards"))
            {
                var i = 0;
                while(i < materials.count)
                {
                    if(materials[i] == "cards")
                    {
                        break
                    }
                    i = i+1
                }
                materials.remove(at: i)
            }
        }
    }
    @IBAction func cupsSwitch(_ sender: UISwitch) {
        print("cups switched")
        if(cupSwitchOutlet.isOn)
        {
            if(!materials.contains("cups"))
            {
                materials.append("cups")
            }
        }
        else //remove cups
        {
            if(materials.contains("cups"))
            {
                var i = 0;
                while(i < materials.count)
                {
                    if(materials[i] == "cups")
                    {
                        break
                    }
                    i = i+1
                }
                materials.remove(at: i)
            }
        }
    }
    @IBAction func pongSwitch(_ sender: Any) {
        print("pong switched")
        if(pongSwitchOutlet.isOn)
        {
            if(!materials.contains("Ping Pong Balls"))
            {
                materials.append("Ping Pong Balls")
            }
        }
        else //remove pong balls
        {
            if(materials.contains("Ping Pong Balls"))
            {
                var i = 0;
                while(i < materials.count)
                {
                    if(materials[i] == "Ping Pong Balls")
                    {
                        break
                    }
                    i = i+1
                }
                materials.remove(at: i)
            }
        }
    }
    @IBAction func coinsSwitch(_ sender: UISwitch) {
        print("coins switched")
        if(coinSwitchOutlet.isOn)
        {
            if(!materials.contains("coin"))
            {
                materials.append("coin")
            }
        }
        else //remove coins
        {
            if(materials.contains("coin"))
            {
                var i = 0;
                while(i < materials.count)
                {
                    if(materials[i] == "coin")
                    {
                        break
                    }
                    i = i+1
                }
                materials.remove(at: i)
            }
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        print("Submit Selected")
        print("Number of players: ",numPlayers, "\nMaterials: ", materials)
        //gamesReduced.removeAll()
        //reduceGames()
        //printReducedGames()
        
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
                //gameDataAdded = true;
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
    
    func reduceGames()
    {
        //use perameters chosen by user to populate the games reduced array
        //games reduced will be passed to the table view to populate the table from the submit button
        for g in GamesArray
        {
            if(gameMCheck(g: g) && gamePCheck(g: g) && gameSCheck(g: g))
            {
                gamesReduced.append(g)
            }
            if(g.outdoor == true && g.indoor == false && settingOut == true)
            {
                gamesReduced.append(g)
            }
        }
        
        //gamesReduced = GamesArray
        
    }
    func gameMCheck(g : game) -> Bool
    {
        for m in materials
        {
            if g.materials.lowercased().range(of: m.lowercased()) != nil
            {
                print(g.gameName, " Material match: ", m)
                return true
            }

        }
        return false
    }
    func gamePCheck(g : game) -> Bool
    {
        if((g.minPlayers <= numPlayers && numPlayers <= g.maxPlayers))
        {
            //print(g.gameName, " numPlayers match: ", g.minPlayers, " < ",numPlayers ," < ", g.maxPlayers)
            return true
        }
        else if((g.minPlayers <= numPlayers - 1 && numPlayers - 1 <= g.maxPlayers))
        {
            //print(g.gameName, " numPlayers match: ", g.minPlayers, " < ",numPlayers - 1 ," < ", g.maxPlayers)
            return true
        }
        else if((g.minPlayers <= numPlayers - 2 && numPlayers - 2 <= g.maxPlayers))
        {
            //print(g.gameName, " numPlayers match: ", g.minPlayers, " < ",numPlayers - 2 ," < ", g.maxPlayers)
            return true
        }
        else if((g.minPlayers <= numPlayers - 3 && numPlayers - 3 <= g.maxPlayers))
        {
            //print(g.gameName, " numPlayers match: ", g.minPlayers, " < ",numPlayers - 3 ," < ", g.maxPlayers)
            return true
        }
        else if((g.minPlayers <= numPlayers - 4 && numPlayers - 4 <= g.maxPlayers))
        {
            //print(g.gameName, " numPlayers match: ", g.minPlayers, " < ",numPlayers - 4 ," < ", g.maxPlayers)
            return true
        }
        return false
    }
    
    func gameSCheck(g : game) -> Bool
    {
        if(g.indoor == true && settingIn == true || g.outdoor == true && settingOut == true)
        {
            return true
        }
        return false
    }
    
    func printReducedGames()
    {
        print("Games that match: ")
        for g in gamesReduced
        {
            print("  ", g.gameName)
        }
        
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
                        print("fetched Secondary Color: ", sC)
                        tempScolor = sC
                    }
                }
            }
            
        } catch {print("There was a fetch error")}
        
    }
    
    func setSecondaryColor() -> UIColor
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
    
    func setPrimaryColor() -> UIColor
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGameData()
        fetchSettingsDataCols()
        let pCol = setPrimaryColor()
        var sCol = setSecondaryColor()
        if(sCol == pCol && sCol != UIColor.black){sCol = UIColor.black}
        else if(sCol == pCol){sCol = UIColor.white}
        
        self.view.backgroundColor = pCol
        self.view.tintColor = sCol
        numPlayersLabel.textColor = sCol
        materialsAvailableLabel.textColor = sCol
        cardsLabel.textColor = sCol
        cupsLabel.textColor = sCol
        pongLabel.textColor = sCol
        coinsLabel.textColor = sCol
        settingLabel.textColor = sCol
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "FinderToEn")
        {
            reduceGames()
            printReducedGames()
            //let gameName = "Game Name From Encyclopedia"
            let destinationVC = segue.destination as! EncyclopediaTableViewController
            destinationVC.reducedGames = gamesReduced
            destinationVC.fromFinder = true
            
        }
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
