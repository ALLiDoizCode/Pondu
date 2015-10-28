//
//  ViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventLikes: UILabel!
    let mainWall = PresentMainWall()
    let Parties = PartiesMainWall()
    let user = users()
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var commetns: UILabel!
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
        favorite.getFavorite(testLabel, icon: eventImage, likes: eventLikes, comments: commetns, name: name)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

