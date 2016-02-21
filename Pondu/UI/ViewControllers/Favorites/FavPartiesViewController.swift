//
//  FavPartiesViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/10/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Kingfisher
import QuartzCore
import Spring
import BubbleTransition

class FavPartiesViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate {

    var array:[Event] = []
    let transition = BubbleTransition()
    let party = PartiesMainWall()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UltravisualLayout!
    
    override func viewWillAppear(animated: Bool) {
        
        party.favPost { (result) -> Void in
            
            self.array = result
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.collectionView.reloadData()
            }
            
            print("we got the fav data")
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
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return array.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:FavPartyCell = collectionView.dequeueReusableCellWithReuseIdentifier("FavPartyCell", forIndexPath: indexPath) as! FavPartyCell
        
        cell.post.text = array[indexPath.row].post
        cell.PostName.text = array[indexPath.row].name
        cell.likes.text = "Likes:\(array[indexPath.row].likes)"
        
        cell.profileImage.kf_setImageWithURL(NSURL(string:array[indexPath.row].profilePicture)!, placeholderImage: UIImage(named: "placeholder"))
        cell.bgImage.kf_setImageWithURL(NSURL(string:array[indexPath.row].profilePicture)!, placeholderImage: UIImage(named: "placeholder"))
        
        
        if array[indexPath.row].live == true {
            
            cell.live.text = "Live"
            cell.live.repeatCount = Float.infinity
            cell.live.animate()
            
        }else {
            
            
            cell.live.text = "Peak"
            cell.live.textColor = UIColor.whiteColor()
        }
        
        
        print("post in array \(self.array.count)")
        
        cell.layoutSubviews()
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
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
            
          
            print(item)
            
        }
    }

}
