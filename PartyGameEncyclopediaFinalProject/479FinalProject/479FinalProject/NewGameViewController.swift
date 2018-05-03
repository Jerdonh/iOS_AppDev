//
//  NewGameViewController.swift
//  479FinalProject
//
//  Created by Jerdon Helgeson on 5/1/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit
import CoreData

class NewGameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var imageFileData = ["CanAndCards.jpg","Cards.jpg","Cornhole.jpg","Cups.jpg","GlassAndCoin.jpg","hands.jpg","Jenga.jpg","kickball.jpeg","LadderBall.jpg","moose.jpg","rtbCards.jpeg"]
    
    var imageFileName = "goldStar.jpeg"
    var daGame: game = game(gameName: "")
    var daNewGame: game = game(gameName: "")
    var GamesArray = [game]()
    var gameDataAdded = false;
    var gamesNS = [NSManagedObject]();
    var tempPcolor = ""
    var tempScolor = ""
    
    @IBOutlet weak var theView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var materialsLabel: UILabel!
    @IBOutlet weak var rulesLabel: UILabel!
    
    
    @IBOutlet weak var titleTextOutlet: UITextField!
    @IBOutlet weak var minTextOutlet: UITextField!
    @IBOutlet weak var maxTextOutlet: UITextField!
    @IBOutlet weak var materialsTextOutlet: UITextView!
    @IBOutlet weak var rulesTextOutlet: UITextView!
    
    @IBOutlet weak var saveButtonOutlet: NSLayoutConstraint!
    
    @IBOutlet weak var imagePickerOutlet: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePickerOutlet.delegate = self
        self.imagePickerOutlet.dataSource = self
        titleTextOutlet.text = "Enter Game Title Here"
        materialsTextOutlet.text = "Enter materials, separated by commas, here "
        rulesTextOutlet.text = "Enter rules here,\n\nEach rule should be separated by comma and a new line"
        
        fetchGameData()
        fetchSettingsDataCols()
        let pCol = setPrimaryColor()
        var sCol = setSecondaryColor()
        if(sCol == pCol && sCol != UIColor.black){sCol = UIColor.black}
        else if(sCol == pCol){sCol = UIColor.white}
        
        self.view.backgroundColor = pCol
        view.backgroundColor = pCol
        theView.backgroundColor = pCol
        self.view.tintColor = sCol
        titleLabel.textColor = sCol
        maxLabel.textColor = sCol
        maxTextOutlet.textColor = sCol
        minTextOutlet.textColor = sCol
        minLabel.textColor = sCol
        rulesLabel.textColor = sCol
        materialsLabel.textColor = sCol
        imageLabel.textColor = sCol
        titleTextOutlet.textColor = sCol
        materialsTextOutlet.textColor = sCol
        rulesTextOutlet.textColor = sCol
        materialsTextOutlet.backgroundColor = pCol
        rulesTextOutlet.backgroundColor = pCol
        if(pCol == UIColor.black)
        {imagePickerOutlet.backgroundColor = sCol}
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageFileData[row]
        //else{return SecondaryPickerData[row]}
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Image Selected: ",imageFileData[row])
        imageFileName = imageFileData[row]
    }
    
    
    
    @IBAction func Save(_ sender: UIButton) {
        print("Save Button Pressed")
        deleteGameCoreData()
        editDaNewGames()
        addBaseData()
        
    }
    
    
    func editDaNewGames()
    {
        daNewGame.gameName = titleTextOutlet.text!
        daNewGame.imageFileName = imageFileName
        daNewGame.minPlayers = Int(minTextOutlet.text!)!
        daNewGame.maxPlayers = Int(maxTextOutlet.text!)!
        daNewGame.materials = materialsTextOutlet.text
        daNewGame.rules = rulesTextOutlet.text
        
        GamesArray.append(daNewGame)
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
    
    func addBaseData()
    {
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
            //Process Error
        }
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
    
    func entityIsEmpty(entity: String) -> Bool
    {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Game")
        
        do{
            let results = try context.fetch(request)
            if(results.count == 0)
            {
                return true;
            }
            else{return false}
        }catch
        {
            print("there was a fetch error in enityIsEmpty")
            return false
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
