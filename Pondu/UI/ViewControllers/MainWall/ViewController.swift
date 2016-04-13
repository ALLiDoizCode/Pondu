//
//  ViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Kingfisher
import QuartzCore
import SwiftDate
import Spring
import BubbleTransition
import FXBlurView

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate {
    
    let eventID:[String] = []
    var count:Int = 0
    var objectId:String!
    var array:[Wall] = []
    var numOfCells:[String] = []
    var numOfPost:[String] = []
    var indexOfUrl:[Character] = []
    let transition = BubbleTransition()
    
    let liveConent = AddContent()
    
    let presenter = PresentMainWall()
    
    @IBOutlet weak var blur: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailLive: UIButton!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailPost: UILabel!
    @IBOutlet weak var detailLocation: UILabel!
    @IBOutlet weak var detailAddress: UIButton!
    @IBOutlet weak var detailTimteLabel: UILabel!
    @IBOutlet weak var detailTime: UILabel!
    @IBOutlet weak var detailDate: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UltravisualLayout!
    
    let swipeDownRect = UISwipeGestureRecognizer()
    
    override func viewWillAppear(animated: Bool) {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        blur.addSubview(blurEffectView)
        blur.backgroundColor = UIColor.clearColor()
        detailView.backgroundColor = UIColor.whiteColor()
        detailView.layer.borderColor = UIColor.lightGrayColor().CGColor
        detailView.layer.borderWidth = 0.5
        detailView.hidden = true
        blur.hidden = true
       // blur.blurRadius = 5
    
        presenter.eventPost { (result) in
            
           self.array = result
            
            self.reload()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transition.duration = 0.4
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload(){
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return array.count
        
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:MainCell = collectionView.dequeueReusableCellWithReuseIdentifier("MainCell", forIndexPath: indexPath) as! MainCell
        
        cell.post.text = array[indexPath.item].post
        cell.eventTitle.text = array[indexPath.item].title
        cell.descriptionHead.text = array[indexPath.item].title
        cell.PostName.text = array[indexPath.item].createdBy
        cell.likes.text = "Likes:\(array[indexPath.item].likes)"
        
        let file = array[indexPath.item].creatorImage
        
        presenter.getFile(file!, completion: { (data) in
            
            print(data)
            
            cell.profileImage.kf_setImageWithURL(data, placeholderImage: UIImage(named: "placeholder"))
            
        })
        
        if array[indexPath.item].live == true {
        
            cell.live.setTitle("Live", forState: UIControlState.Normal)

            
        }else {
            

            cell.live.setTitle("Peak", forState: UIControlState.Normal)
            cell.live.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
          
        }
        
        
        
        print("post in array \(self.array.count)")
        
        
        
        cell.layoutSubviews()
        
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
    
            swipeDownRect.addTarget(self, action: "swippedDown:")
            swipeDownRect.numberOfTouchesRequired = 1
            swipeDownRect.direction = .Down
            self.view!.addGestureRecognizer(swipeDownRect)
            
            print("featured")
            objectId = array[indexPath.item].entityId
            blur.hidden = false
            detailView.hidden = false
            detailPost.text = array[indexPath.item].description
            detailName.text = array[indexPath.item].title
            //detailTitle.text = cell.descriptionHead.text
            //detailTime.text = cell.time.text
            //detailImage.kf_setImageWithURL(NSURL(string:array[indexPath.row].profilePicture!)!, placeholderImage: UIImage(named: "placeholder"))
            
            
            if array[indexPath.item].live == true {
                
                detailLive.setTitle("Live", forState: UIControlState.Normal)
                
                
            }else {
                
                
                detailLive.setTitle("Peak", forState: UIControlState.Normal)
               detailLive.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
                
            }
            
        }else{
            
            print("not featured")
        }
    }
    
    func swippedDown(sender:UISwipeGestureRecognizer) {
        
        detailView.hidden = true
        blur.hidden = true
        
    }
    
    func goToLive(sender:AnyObject){
        
        self.performSegueWithIdentifier("Live", sender: sender)
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
    
    @IBAction func commentBtn(sender: AnyObject) {
    
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Live" {
            
            let liveController = segue.destinationViewController as! LiveViewController
            
            liveController.transitioningDelegate = self
            liveController.modalPresentationStyle = .Custom
            
            let cell = sender as! MainCell

            let indexPath = self.collectionView!.indexPathForCell(cell)
            
            liveController.eventId = array[(indexPath?.item)!].entityId!
            
        }
        
        if segue.identifier == "Comment" {
            
            let commentViewController = segue.destinationViewController as! CommentViewController
            
            commentViewController.transitioningDelegate = self
            commentViewController.modalPresentationStyle = .Custom
            
            commentViewController.objectId = objectId
            
        }
    }
    
}

