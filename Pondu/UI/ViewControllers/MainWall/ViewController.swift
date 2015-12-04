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
import Kingfisher
import QuartzCore
import SwiftDate
import Spring
import BubbleTransition

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate {
    
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
    var indexOfUrl:[Character] = []
    let transition = BubbleTransition()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UltravisualLayout!
    
    override func viewWillAppear(animated: Bool) {
        
       
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transition.duration = 0.4
        mainWall.eventPost()
        getArrayCount()
        
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //let photo = UIImage(named: "bob")
        //let story = UIImage(named: "story")
        
        //newAccount.AccounSetup("Miami",fullName:"bob",userName:"bob",password:"password",Bio:"bob's bio",email:"bob@bob.com",phone:"555-555-555",photo:photo!,stories:story!)
        
       
        
           
        
        
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
        
        let cell:MainCell = collectionView.dequeueReusableCellWithReuseIdentifier("MainCell", forIndexPath: indexPath) as! MainCell
        
        cell.post.text = array[indexPath.row].post
        cell.PostName.text = array[indexPath.row].name
        cell.likes.text = "Likes:\(array[indexPath.row].likes)"
        cell.time.text = array[indexPath.row].time
        
        let numComments = array[indexPath.row].comments
        
        cell.comments.text = "Comments:\(numComments.count)"
        cell.profileImage.kf_setImageWithURL(NSURL(string:array[indexPath.row].profilePicture)!, placeholderImage: UIImage(named: "placeholder"))
        cell.bgImage.kf_setImageWithURL(NSURL(string:array[indexPath.row].profilePicture)!, placeholderImage: UIImage(named: "placeholder"))
        
        if array[indexPath.row].live == true {
        
            cell.live.text = "Live"
            cell.live.repeatCount = Float.infinity
            cell.live.autostart = true
            print("blink")
            
        }else {
            

            cell.live.text = "Peak"
            cell.live.textColor = UIColor.whiteColor()
          
        }
        
        
        
        print("post in array \(self.array.count)")
        
        
        return cell
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    /////////////////TimeStamp////////////////////////     
       /*let today = NSDate.today().weekdayName
        
        //print(today)
        
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        let theTimeFormat = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = theTimeFormat
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        
        print(DateInFormat)
        print(today)*/
       
  /////////////////TimeStampEnd////////////////////////
        
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
            
            self.performSegueWithIdentifier("Live", sender: indexPath);
            
        }else{
            
            print("not featured")
        }
    }


    
    func getArrayCount(){
        
        SwiftEventBus.onMainThread(self, name: "updateCell") { notification in
            
            print("passing data\(notification.object)")
            
            self.array = notification.object as! [Event]
            
            print(self.array.count)
            
            self.collectionView.reloadData()
            
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = self.view.center
        transition.bubbleColor = UIColor.whiteColor()
        return transition
    }
    
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = self.view.center
        transition.bubbleColor = UIColor.blueColor()
        return transition
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Live" {
            
            let liveController = segue.destinationViewController as! LiveViewController
            
            liveController.transitioningDelegate = self
            liveController.modalPresentationStyle = .Custom

            let item = (sender as! NSIndexPath).item
            
            liveController.fileArray = array[item].liveContent
            print(item)
            
        }
    }
    
}

