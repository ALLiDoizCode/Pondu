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
    let favorite = userFavorites()
    let favParty = partyFavorites()
    let addFavorite = Favorite()
    let eventID:[String] = []
    var count:Int = 0
    var array:[AnyObject] = []
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
        //favParty.getFavorite()
        //
        //mainWall.eventID(eventID )
        //favorite.addFavorite(0)
        //getArrayCount()
        
        //favorite.getFavorite()
        mainWall.eventPost()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let photo = UIImage(named: "bob")
        //let story = UIImage(named: "story")
        
        //newAccount.AccounSetup("Miami",fullName:"bob",userName:"bob",password:"password",Bio:"bob's bio",email:"bob@bob.com",phone:"555-555-555",photo:photo!,stories:story!)
        userLogin.beginLogin("bob", password: "password")

        
        getArrayCount()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numOfCells.count
    }
    
  
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:MainCell = tableView.dequeueReusableCellWithIdentifier("MainCell", forIndexPath: indexPath) as! MainCell
        
        let numOfPost:[String] = array[1] as! [String]
        
        cell.post.text = numOfPost[indexPath.row]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
          addFavorite.userFavorite(numOfCells[indexPath.row])
    }
    
    func getArrayCount(){
        
        SwiftEventBus.onMainThread(self, name: "updateCell") { notification in
            //self.textField.text = "\(self.count)"
            
            print("passing data\(notification.object)")
            
            self.array = notification.object as! [AnyObject]
            
            print(self.array.count)
            
            self.numOfCells = self.array[0] as! [String]
            self.numOfPost = self.array[1] as! [String]
            
            self.tablview.reloadData()
            
        }
    }
    
}

