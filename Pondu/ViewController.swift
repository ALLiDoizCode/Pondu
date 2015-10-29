//
//  ViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let mainWall = PresentMainWall()
    let Parties = PartiesMainWall()
    let user = users()
    let newAccount = SignUP()
    let userLogin = startLogin()
    let favorite = userFavorites()
    let eventID:[String] = []

    override func viewWillAppear(animated: Bool) {
        
        //mainWall.eventPost(testLabel)
        //mainWall.eventIcon(eventImage)
        //mainWall.eventThumb(eventImage)
        //mainWall.eventCL(eventLikes)
        //mainWall.eventCM(eventLikes)
        //mainWall.profileName(eventLikes)
        //mainWall.eventAddress(<#T##button: UIButton##UIButton#>)
        //user.userBio(testLabel)
        //user.userStory(eventImage)
        //user.userFullName(eventLikes)
        //user.userNames(eventLikes)
        //user.userArea(testLabel)
        //user.userPhoto(eventImage)
        //Parties.partiesPost(testLabel)
        //newAccount.AccounSetup(area:String,fullName:String,userName:String,password:String,Bio:String,email:String,phone:String,photo:UIImage,stories:UIImage)
        //userLogin.beginLogin(<#T##UserName: String##String#>, password: <#T##String#>)
        
        //mainWall.eventID(eventID )
        //favorite.addFavorite(0)
        favorite.getFavorite()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
  
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:MainCell = tableView.dequeueReusableCellWithIdentifier("MainCell", forIndexPath: indexPath) as! MainCell
        
        SwiftEventBus.onMainThread(self, name: "updateCellPost") { notification in
            //self.textField.text = "\(self.count)"
            
            print("passing data\(notification.object)")
            
            let array:[String] = notification.object as! [String]
            
            print(array.count)
            
            cell.post.text = notification.object![indexPath.row] as? String
        }
        
        return cell
    }
    

}

