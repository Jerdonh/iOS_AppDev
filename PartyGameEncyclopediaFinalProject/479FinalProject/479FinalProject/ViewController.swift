//
//  ViewController.swift
//  479FinalProject
//
//  Created by Jerdon Helgeson on 4/5/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var tempPcolor = ""
    var tempScolor = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchSettingsDataCols()
        let pCol = setPrimaryColor()
        var sCol = setSecondaryColor()
        if(sCol == pCol && sCol != UIColor.black){sCol = UIColor.black}
        else if(sCol == pCol){sCol = UIColor.white}
        
        self.view.backgroundColor = pCol
        self.view.tintColor = sCol
        titleLabel.textColor = sCol
        //get settings data and update here
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png"))
        
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


}

