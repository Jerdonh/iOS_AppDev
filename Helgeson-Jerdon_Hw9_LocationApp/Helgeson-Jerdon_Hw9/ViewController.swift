//
//  ViewController.swift
//  Helgeson-Jerdon_Hw9
//
//  Created by Jerdon Helgeson on 3/27/18.
//  Copyright © 2018 Jerdon Helgeson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    //properties
    
    let manager = CLLocationManager();
    
    @IBOutlet weak var Latitude: UILabel!
    @IBOutlet weak var Longitude: UILabel!
    @IBOutlet weak var Info: UILabel!
    
    @IBOutlet weak var searchOutlet: UITextField!
    
    @IBAction func Search(_ sender: Any) {
        
        print(searchOutlet.text);
        
    }
    
    @IBAction func SearchButton(_ sender: Any) {
        
        let searchRequest = MKLocalSearchRequest();
        searchRequest.naturalLanguageQuery = searchOutlet.text;
        let activeSearch = MKLocalSearch(request: searchRequest);
        
        
        activeSearch.start { (response, error) in
            
            //activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Remove annotations
                let annotations = self.Map.annotations
                self.Map.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.searchOutlet.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.Map.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.Map.setRegion(region, animated: true)
            }
            
        }
        /*
        let pins = Map.annotations as! [MKAnnotation]
        let currentLocation = self.Map.userLocation.location!;
        
        let nearestPin: MKAnnotation? = pins.reduce((CLLocationDistanceMax, nil)) { (nearest, pin) in
            let coord = pin.coordinate
            let loc = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
            let distance = currentLocation.distance(from: loc)
            return distance < nearest.0 ? (distance, pin) : nearest
            }.1
        
        Info.text = (Info: nearestPin?.title);
        
        */
        
    }
    
    

    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print(searchOutlet.text);
        
    }
    
    
    @IBOutlet weak var Map: MKMapView!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0];
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01);
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span);
        Map.setRegion(region, animated: true);
        Latitude.text = "Latitude: " + String(location.coordinate.latitude) ;
        Longitude.text = "Longitude: " + String(location.coordinate.longitude);
        
        
        
        
        
        self.Map.showsUserLocation = true;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded")
        manager.delegate = self;
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        manager.requestWhenInUseAuthorization();
        manager.startUpdatingLocation();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

