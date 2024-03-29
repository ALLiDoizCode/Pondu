//
//  LocationViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/20/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import LTMorphingLabel
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate,UITextFieldDelegate {

    @IBOutlet weak var mainLabel: LTMorphingLabel!
    @IBOutlet weak var mainLabel2: LTMorphingLabel!
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var next: UIButton!
    var type:Bool!
    var wallType:Bool!
    var timeStart:String!
    var timeEnd:String!
    var date:String!
    var privacy:Bool!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        address.delegate = self
        
        self.title = "Location"

        mainLabel.text = "Where is this Event going to"
        mainLabel.morphingEffect = .Evaporate
        mainLabel.morphingDuration = 0.8
        mainLabel.numberOfLines = 0
        
        mainLabel2.text = "be?"
        mainLabel2.morphingEffect = .Evaporate
        mainLabel2.morphingDuration = 0.8
        mainLabel2.numberOfLines = 0
        mainLabel2.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func locationBtn(sender: AnyObject) {
        
        checkLocationAuthorizationStatus()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        address.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        address.resignFirstResponder()
        
        return false
    }
    
    
    func checkLocationAuthorizationStatus() {
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
            
            //let location = locationManager.location
            
            //let latitude: Double = location!.coordinate.latitude
            //let longitude: Double = location!.coordinate.longitude
            
            //print("current latitude :: \(latitude)")
            //print("current longitude :: \(longitude)")
           
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //--- CLGeocode to get address of current location ---//
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil)
            {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0
            {
                let pm = placemarks![0] as CLPlacemark
                self.displayLocationInfo(pm)
            }
            else
            {
                print("Problem with the data received from geocoder")
            }
        })

    }
    
    
    func displayLocationInfo(placemark: CLPlacemark?)
    {
        if let containsPlacemark = placemark
        {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            // Address dictionary
            print(containsPlacemark.addressDictionary)
            
            // Location name
            /*if let locationName = containsPlacemark.addressDictionary!["Name"] as? NSString {
                print(locationName)
            }*/
            
            // Street address
            /*if let street = containsPlacemark.addressDictionary!["Thoroughfare"] as? NSString {
                print(street)
            }*/
            
            // City
            if let locationName = containsPlacemark.addressDictionary!["Name"] as? NSString ,let city =  containsPlacemark.addressDictionary!["City"] as? NSString, let state = containsPlacemark.addressDictionary!["State"] as? NSString, let zip = containsPlacemark.addressDictionary!["ZIP"] as? NSString, let country = containsPlacemark.addressDictionary!["Country"] as? NSString {
                
                print(locationName)
                print(city)
                print(state)
                print(zip)
                print(country)
                
                address.text = "\(locationName) \(city) \(state) \(zip)"
            }
            
            /*if let state = containsPlacemark.addressDictionary!["State"] as? NSString {
                print(state)
            }
            
            // Zip code
           if let zip = containsPlacemark.addressDictionary!["ZIP"] as? NSString {
                print(zip)
            }
            
            // Country
            if let country = containsPlacemark.addressDictionary!["Country"] as? NSString {
                print(country)
            }*/
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error while updating location " + error.localizedDescription)
    }

    @IBAction func nextBtn(sender: AnyObject) {
        
        if address.text != "" {
            
            self.performSegueWithIdentifier("Post", sender: self)
            
        }else{
            
            print("post alert for no selection")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Post" {
            
            let nextViewController:PostViewController = segue.destinationViewController as! PostViewController
            
            nextViewController.type = type
            nextViewController.wallType = wallType
            nextViewController.timeStart = timeStart
            nextViewController.timeEnd = timeEnd
            nextViewController.date = date
            nextViewController.address = address.text
            nextViewController.privacy = privacy
            print("passing \(type)")
            print("passing \(wallType)")
            print("passing \(date)")
            print("passing \(timeEnd)")
            print("passing \(timeStart)")
            print("passing \(address.text)")
            print("passing \(privacy)")
            
        }
    }
    

}
