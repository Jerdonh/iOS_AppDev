//
//  settingsViewController.swift
//  HelgesonJerdon_Hw6_settings
//
//  Created by Jerdon Helgeson on 2/19/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {

    //properties
        //ioData
    var SortByStr : String?
    var ShowImageStr : String?
        //fields
    @IBOutlet weak var SortBy: UITextField!
    @IBOutlet weak var ShowImage: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Distances: UITextField!
    
    
    
    //methods
    func setLocal()
    {
        if(ShowImageStr != nil)
        {ShowImage.text = ShowImageStr}
        if(SortByStr != nil)
        {SortBy.text = SortByStr}
    }
    func setDevice()
    {
        if(UserDefaults.standard.string(forKey: "Name") != nil)
        {self.Name.text = "Name: "+UserDefaults.standard.string(forKey: "Name")!}
        
        
        
    }
    
    @IBAction func ChangeLocal(_ sender: Any) {
    }
    
    
    @IBAction func ChangeDevice(_ sender: Any) {
        
        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString){
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                print("Device Settings Reached")
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocal()
        setDevice()
        // Do any additional setup after loading the view.
        //let controller = storyboard?.instantiateViewController(withIdentifier: "NavController")
        //if(controller != nil)
        //{self.navigationController!.pushViewController(controller!, animated: false)}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "Local")
        {
            //if(ShowImageOutlet.selected == ){}
            let local = segue.destination as! settingsTableViewController
            //settings.SortBy.text = SortBy
            local.ShowImageStr = self.ShowImage.text!
            local.SortByStr = self.SortBy.text!
        }
            
        else{
            /*var showTripController = segue.destination as! ViewController
             isShowSegue = true;
             showTripController.showTrip = showTrip;*/}
        
    }

    

}
