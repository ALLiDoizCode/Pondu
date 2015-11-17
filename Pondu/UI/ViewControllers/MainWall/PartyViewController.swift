//
//  PartyViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/6/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse
import Kingfisher
import QuartzCore
import Spring

class PartyViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    let mainWall = PresentMainWall()
    let Parties = PartiesMainWall()
    let user = theUser()
    let newAccount = SignUP()
    let userLogin = startLogin()
    let eventID:[String] = []
    var count:Int = 0
    var array:[Event] = []
    var numOfCells:[String] = []
    var numOfPost:[String] = []
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UltravisualLayout!
    
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
        
        //mainWall.eventID(eventID )
        //favorite.addFavorite(0)
        //mainWall.eventPost()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Parties.partiesPost()
        getArrayCount()
        
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //let photo = UIImage(named: "bob")
        //let story = UIImage(named: "story")
        
        //newAccount.AccounSetup("Miami",fullName:"bob",userName:"bob",password:"password",Bio:"bob's bio",email:"bob@bob.com",phone:"555-555-555",photo:photo!,stories:story!)
        
        
        
        //let favorite = userFavorites()
        //favorite.getFavorite()
        
        //let favParty = partyFavorites()
        //favParty.getFavorite()
        
        
        /*let name = "jonathan"
        let post = "just created another post"
        let profileImage = UIImage(named: "bob")
        let location = "3300 University Blvd, Winter Park, FL 32792"
        let likes = 0
        let live = false
        
        let makeEvent = MakingEvent()
        makeEvent.event(name, thePost: post, TheProfilePicture: profileImage!, theLocation: location, theLive: live,thelikes:likes)*/
        
        /*let makeParty = MakingParty()
        makeParty.party(name, thePost: post, TheProfilePicture: profileImage!, theLocation: location, theLive: live,thelikes:likes)*/
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return array.count
        
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:PartyCell = collectionView.dequeueReusableCellWithReuseIdentifier("PartyCell", forIndexPath: indexPath) as! PartyCell
        
        cell.post.text = array[indexPath.row].post
        cell.PostName.text = array[indexPath.row].name
        cell.likes.text = "Likes:\(array[indexPath.row].likes)"
        
        let numComments = array[indexPath.row].comments
        
        cell.comments.text = "Comments:\(numComments.count)"
        cell.profileImage.kf_setImageWithURL(NSURL(string:array[indexPath.row].profilePicture)!, placeholderImage: nil)
    
        cell.bgImage.kf_setImageWithURL(NSURL(string:array[indexPath.row].profilePicture)!, placeholderImage: nil)
        
        
        
        if array[indexPath.row].live == true {
            
            //cell.pulseEffect.hidden = false
            
            cell.live.text = "Live"
            cell.live.repeatCount = Float.infinity
            cell.live.animate()
        }else {
            
            
            cell.live.text = "Peak"
            cell.live.textColor = UIColor.whiteColor()
        }
        
        
        
        print("post in array \(self.array.count)")
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //let addFavorite = Favorite()
        //addFavorite.userFavorite(array[indexPath.row].objectID)
        //addFavorite.userPartyFavorite(array[indexPath.row].objectID)
        
        let layout = collectionViewLayout as UltravisualLayout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
        
        if indexPath.item == layout.featuredItemIndex {
            
            print("featured")
        }
    }
    
    
    func getArrayCount(){
        
        SwiftEventBus.onMainThread(self, name: "updatePartyCell") { notification in
            
            print("passing data\(notification.object)")
            
            self.array = notification.object as! [Event]
            
            print(self.array.count)
            
            self.collectionView.reloadData()
            
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
