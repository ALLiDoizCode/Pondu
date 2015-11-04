//
//  ViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let mainWall = PresentMainWall()
    let Parties = PartiesMainWall()
    let user = users()
    let newAccount = SignUP()
    let userLogin = startLogin()
    let eventID:[String] = []
    var count:Int = 0
    var array:[Event] = []
    var numOfCells:[String] = []
    var numOfPost:[String] = []
    
    @IBOutlet weak var tablview: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        
        //mainWall.eventPost()
        //mainWall.eventIcon()
        //mainWall.eventThumb()
        //mainWall.eventCL()
        //mainWall.eventCM()
        //mainWall.profileName()
        //mainWall.eventAddress()
        //user.userBio()
        //user.userStory()
        //user.userFullName()
        //user.userNames()
        //user.userArea()
        //user.userPhoto()
        //Parties.partiesPost()
        //mainWall.eventID(eventID )
        //favorite.addFavorite(0)
        //mainWall.eventPost()
        
        userLogin.beginLogin("bob", password: "password")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let photo = UIImage(named: "bob")
        //let story = UIImage(named: "story")
        
        //newAccount.AccounSetup("Miami",fullName:"bob",userName:"bob",password:"password",Bio:"bob's bio",email:"bob@bob.com",phone:"555-555-555",photo:photo!,stories:story!)
        
        //getArrayCount()
        
        //let favorite = userFavorites()
        //favorite.getFavorite()
        
         //let favParty = partyFavorites()
         //favParty.getFavorite()
        
        
            let name = "jonathan"
            let post = "just created this post"
            let profileImage = UIImage(named: "bob")
            let location = "3300 University Blvd, Winter Park, FL 32792"
            let live = false
        
         let makeEvent = MakeEvent()
        makeEvent.event(name, thePost: post, TheProfilePicture: profileImage!, theLocation: location, theLive: live)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array.count
    }
    
  
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:MainCell = tableView.dequeueReusableCellWithIdentifier("MainCell", forIndexPath: indexPath) as! MainCell
        
        cell.post.text = array[indexPath.row].post
        
        print("post in array \(self.numOfCells)")
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let addFavorite = Favorite()
        //addFavorite.userFavorite(numOfCells[indexPath.row])
        addFavorite.userPartyFavorite(numOfCells[indexPath.row])
    }
    
    func getArrayCount(){
        
        SwiftEventBus.onMainThread(self, name: "updateCell") { notification in
            //self.textField.text = "\(self.count)"
            
            print("passing data\(notification.object)")
            
            self.array = notification.object as! [Event]
            
            print(self.array.count)
            
            /*if self.array.count == 1 {
                
                /*print("the Array has \(self.array.count)")
                self.numOfCells = self.array[0] as! [String]
                self.numOfPost = self.array[0] as! [String]*/
            }else{
                /*print("the Party Array has \(self.array.count)")
                self.numOfCells = self.array[1] as! [String]
                self.numOfPost = self.array[0] as! [String]*/
                
            }*/
            
            self.tablview.reloadData()
            
        }
    }
    
}

