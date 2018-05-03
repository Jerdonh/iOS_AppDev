//
//  AboutViewController.swift
//  479FinalProject
//
//  Created by Jerdon Helgeson on 4/5/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit
import CoreData

var tempPcolor = ""
var tempScolor = ""

class AboutViewController: UIViewController {

    @IBOutlet weak var AppDescriptionLabel: UILabel!
    @IBOutlet weak var Disclaimer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSettingsDataCols()
        let pCol = setPrimaryColor()
        var sCol = setSecondaryColor()
        if(sCol == pCol && sCol != UIColor.black)
        {sCol = UIColor.black}
        else{sCol = UIColor.white}
        self.view.backgroundColor = pCol
        self.view.tintColor = sCol
        loadLabels()
        AppDescriptionLabel.textColor = sCol
        Disclaimer.textColor = sCol
        //retrieve all core data settings info here and load settings on viewdidload
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadLabels()
    {
        AppDescriptionLabel.textAlignment = NSTextAlignment.center;
        AppDescriptionLabel.numberOfLines = 0;
        AppDescriptionLabel.font = UIFont.systemFont(ofSize: 20.0);
        AppDescriptionLabel.text = "Game Encycopedia is the customizable party game encyclopedia! \n\n Pull it out whenever there is a lull in the action, to pick the optimal game for your party. \n\n Discover and new games with the Find Your Game feature! \n\n Add and Manage games in the encyclopedia to reflect your house rules! \n\n Have a game that you're dying to share with the world? Submit it to the developers and have your name immortalized in the app!";
        Disclaimer.textAlignment = NSTextAlignment.center;
        Disclaimer.numberOfLines = 0;
        Disclaimer.font = UIFont.systemFont(ofSize: 12.0);
        Disclaimer.text = "Developers of Game Encyclopedia in no way encourage the abuse of alcoholic beverages, nor do we encourage the use of alcoholic beverages by minors. By using this app the user agrees to take full responsibility for his or her actions as the Game Encyclopedia in no way shape or form encourages or forces any person to play games or consumer alcohol. Game Encyclopedia is simply an app that teaches the rules of iconic party games. If the user or anyone associated with the user should choose to consume alcoholic beverages, they are assuming liability for all consequences of their actions. If you should choose to consume alcoholic beverages we encourage you to do it responsibly. "
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
