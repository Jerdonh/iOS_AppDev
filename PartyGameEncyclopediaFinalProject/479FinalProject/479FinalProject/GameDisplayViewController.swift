//
//  GameDisplayViewController.swift
//  479FinalProject
//
//  Created by Jerdon Helgeson on 4/19/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit
import CoreData



class GameDisplayViewController: UIViewController {

    var GamesArray = [game]()
    var gameDataAdded = false;
    
    
    @IBOutlet weak var MaterialsLabel: UILabel!
    @IBOutlet weak var GameTitle: UILabel!
    @IBOutlet weak var GameImage: UIImageView!
    @IBOutlet weak var numPlayersLabel: UILabel!
    
    @IBOutlet weak var RulesTitle: UILabel!
    @IBOutlet weak var RulesLabel: UILabel!
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var innerView: UIView!
    
    
    //Rating Stars
    var globalCounter: Int = 0;
    var ratingUpdated: Bool = false;
    @IBOutlet weak var Star1: UIImageView!
    @IBOutlet weak var Star2: UIImageView!
    @IBOutlet weak var Star3: UIImageView!
    @IBOutlet weak var Star4: UIImageView!
    @IBOutlet weak var Star5: UIImageView!

    
    
    
    var gameName = ""
    var daGame: game = game(gameName: "")
    var tempPcolor = ""
    var tempScolor = ""
    var gamesNS = [NSManagedObject]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scroller.contentSize = CGSize(width: self.view.frame.width,height: self.view.frame.height+100)
        scroller.isScrollEnabled = true
        
        //self.navigationItem.hidesBackButton = true // setHidesBackButton:YES]
        
        let tapGestureReconizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)));
        let tapGestureReconizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)));
        let tapGestureReconizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)));
        let tapGestureReconizer4 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)));
        let tapGestureReconizer5 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)));
        Star1.isUserInteractionEnabled = true;
        Star1.addGestureRecognizer(tapGestureReconizer1);
        Star2.isUserInteractionEnabled = true;
        Star2.addGestureRecognizer(tapGestureReconizer2);
        Star3.isUserInteractionEnabled = true;
        Star3.addGestureRecognizer(tapGestureReconizer3);
        Star4.isUserInteractionEnabled = true;
        Star4.addGestureRecognizer(tapGestureReconizer4);
        Star5.isUserInteractionEnabled = true;
        Star5.addGestureRecognizer(tapGestureReconizer5);
        
        
        
        fetchSettingsDataCols()
        let pCol = setPrimaryColor()
        var sCol = setSecondaryColor()
        if(sCol == pCol && sCol != UIColor.black){sCol = UIColor.black}
        else if(sCol == pCol){sCol = UIColor.white}
        
        
        self.view.backgroundColor = pCol
        self.view.tintColor = sCol
        scroller.backgroundColor = pCol
        innerView.backgroundColor = pCol
        GameTitle.textColor = sCol
        GameTitle.text = daGame.gameName
        formatStars()
        MaterialsLabel.textColor = sCol
        MaterialsLabel.numberOfLines = 0
        formatMaterialsLabel()
        print("IMAGE FILE NAME:", daGame.imageFileName!)
        
        let miP = String(daGame.minPlayers)
        let maP = String(daGame.maxPlayers)
        print("numPlayers: ", miP, "-", maP)
        numPlayersLabel.text = "Number of Players: " + miP + "-" + maP
        numPlayersLabel.textColor = sCol
        
        RulesTitle.textColor = sCol
        formatRulesLabel(color: sCol)
        if(daGame.imageFileName != nil)
        {GameImage.image = UIImage(named: daGame.imageFileName!)!}
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func formatStars()
    {
        
        print("GAME RATING: ", daGame.rating)
        
        Star1.image = UIImage(named: "silverStar.png")!
        Star2.image = UIImage(named: "silverStar.png")!
        Star3.image = UIImage(named: "silverStar.png")!
        Star4.image = UIImage(named: "silverStar.png")!
        Star5.image = UIImage(named: "silverStar.png")!
        if(daGame.rating == 5)
        {
            Star1.image = UIImage(named: "goldStar.png")!
            Star2.image = UIImage(named: "goldStar.png")!
            Star3.image = UIImage(named: "goldStar.png")!
            Star4.image = UIImage(named: "goldStar.png")!
            Star5.image = UIImage(named: "goldStar.png")!
            
        }
        else if(daGame.rating == 4)
        {
            Star1.image = UIImage(named: "goldStar.png")!
            Star2.image = UIImage(named: "goldStar.png")!
            Star3.image = UIImage(named: "goldStar.png")!
            Star4.image = UIImage(named: "goldStar.png")!
        }
        else if(daGame.rating == 3)
        {
            Star1.image = UIImage(named: "goldStar.png")!
            Star2.image = UIImage(named: "goldStar.png")!
            Star3.image = UIImage(named: "goldStar.png")!
        }
        else if(daGame.rating == 2)
        {
            Star1.image = UIImage(named: "goldStar.png")!
            Star2.image = UIImage(named: "goldStar.png")!
        }
        else if(daGame.rating == 1)
        {
            Star1.image = UIImage(named: "goldStar.png")!
            
        }
    }
    
    func formatMaterialsLabel()
    {
        var tempStr = daGame.materials
        var i = 0
        var o = 1
        for char in tempStr
        {
            if(char == ",")
            {
                let index = tempStr.characters.index(tempStr.startIndex, offsetBy: i+o)
                let tempStart = tempStr.prefix(upTo: index)
                let tempEnd = tempStr.suffix(from: index)
                tempStr = tempStart + "\n" + tempEnd
                o = o+1
            }
            
            i = i + 1
        }
        MaterialsLabel.text = "Materials: \n " + tempStr
        
    }
    func formatRulesLabel(color: UIColor)
    {
        RulesLabel.textColor = color
        RulesLabel.numberOfLines = 0
        var tempStr = daGame.rules
        var i = 0
        var o = 1
        for char in tempStr
        {
            if(char == ",")
            {
                let index = tempStr.characters.index(tempStr.startIndex, offsetBy: i+o)
                let tempStart = tempStr.prefix(upTo: index)
                let tempEnd = tempStr.suffix(from: index)
                tempStr = tempStart + "\n" + tempEnd
                o = o+1
            }
            
            i = i + 1
        }
        
        RulesLabel.text = tempStr
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let sStar = UIImage(named : "silverStar.png")
        let gStar = UIImage(named : "goldStar.png")
        var gFixer = globalCounter; if(gFixer > 2){gFixer = 0};if(gFixer < 0){gFixer = 2;}
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if(tappedImage == Star1)
        {
            print("Star1 tapped")
            Star1.image = gStar; Star2.image = sStar; Star3.image = sStar; Star4.image = sStar; Star5.image = sStar;
            daGame.rating = 1
            //set star1 gold and rating = 1
            //trips[gFixer].rating = 1
        }
        else if(tappedImage == Star2)
        {
            print("Star2 tapped")
            Star1.image = gStar; Star2.image = gStar; Star3.image = sStar; Star4.image = sStar; Star5.image = sStar;
            daGame.rating = 2
            //set star1 & 2 gold and rating = 2
            //trips[gFixer].rating = 2
        }
        else if(tappedImage == Star3)
        {
            print("Star3 tapped")
            Star1.image = gStar; Star2.image = gStar; Star3.image = gStar; Star4.image = sStar; Star5.image = sStar;
            daGame.rating = 3
            //set star1,2,3 gold and rating = 3
            //trips[gFixer].rating = 3
        }
        else if(tappedImage == Star4)
        {
            print("Star4 tapped")
            Star1.image = gStar; Star2.image = gStar; Star3.image = gStar; Star4.image = gStar; Star5.image = sStar;
            daGame.rating = 4
            //set star1,2,3,4 gold and rating = 4
            //trips[gFixer].rating = 4
        }
        else if(tappedImage == Star5)
        {
            print("Star5 tapped")
            Star1.image = gStar; Star2.image = gStar; Star3.image = gStar; Star4.image = gStar; Star5.image = gStar;
            daGame.rating = 5
            //set star1,2,3,4,5 gold and rating = 5
            //trips[gFixer].rating = 5
        }
        ratingUpdated = true
        print("Rating has been updated")
        
    }
    
    
    func updateRating()
    {
        //This should only be called if the rating has been changed && if a segue is about to happen so you dont have to edit the core data every time someone clicks the rating stars
        
        //1. fetch the array of origional games
        fetchGameData()
        //2. find the game that is currently being edited and update the rating in the games array
        var n = 0
        while(n < GamesArray.count)
        {
            if(GamesArray[n].gameName == daGame.gameName)
            {
                GamesArray[n].rating = daGame.rating
                break
            }
            n = n+1
        }
        //3. delete the core date
        deleteGameCoreData()
        //4. replace the core data with the new array
        addBaseData()
        
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
                gameDataAdded = true;
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
    
    func deleteGameCoreData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        //let newSettings = NSEntityDescription.insertNewObject(forEntityName: "Game", into: context);
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Game")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(batchDeleteRequest)
            
        } catch {
            print("ohmygod")
        }
        
        
        do{
            var results = try context.fetch(request)
            results.removeAll();
        }catch{print("ohmygod")}
        
        for sNS in gamesNS
        {
            context.delete(sNS)
        }
        gamesNS.removeAll()
        //reloadData()
        
    }
    
    func addBaseData()
    {
        //populateGamesArray()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        guard let entity = NSEntityDescription.entity(forEntityName: "Game", in: context) else {fatalError("Could not find entity description")}
        
        for g in GamesArray
        {
            let gam2CD = NSManagedObject(entity: entity, insertInto: context)
            gam2CD.setValue(g.gameName, forKey: "gameName")
            gam2CD.setValue(g.classic, forKey: "classic")
            gam2CD.setValue(g.gameType, forKey: "gameType")
            gam2CD.setValue(g.imageFileName, forKey: "imageFileName")
            gam2CD.setValue(g.indoor, forKey: "indoor")
            gam2CD.setValue(g.materials, forKey: "materials")
            gam2CD.setValue(g.maxPlayers, forKey: "maxPlayers")
            gam2CD.setValue(g.minPlayers, forKey: "minPlayers")
            gam2CD.setValue(g.outdoor, forKey: "outdoor")
            gam2CD.setValue(g.rating, forKey: "rating")
            gam2CD.setValue(g.rules, forKey: "rules")
            gam2CD.setValue(g.alternateNames, forKey: "alternateNames")
        }
        do
        {
            try context.save()
            print("SAVED")
        }
        catch
        {
            print("error adding Core Data withing function addBaseData ")
            //Process Error
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Back2Encyclopedia")
        {
            if(ratingUpdated == true)
            {
                print("Seque Begun and Rating edited by user.")
                updateRating()
                print("updateRating() successfully called")
            }
        }
        else if(segue.identifier == "Display2Edit")
        {
            let destinationVC = segue.destination as! EditGameViewController
            destinationVC.daGame = daGame
            
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
