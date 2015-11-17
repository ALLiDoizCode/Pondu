//
//  StoryListViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/14/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Kingfisher
 
private let reuseIdentifier = "StoryCell"

class StoryListViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var mainImage: UIImageView!
    var array:[userData] = []
    var storyUser:theUser = theUser()
    
    override func viewWillAppear(animated: Bool) {
        
        
        SwiftEventBus.onMainThread(self, name: "updateStory") { notification in
            
            print("passing data\(notification.object)")
            
            self.array = notification.object as! [userData]
            
            self.collectionView.reloadData()
            
            print("this is the first picture\(self.array[1].story)")
            
        }
        
        storyUser.theUsers()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.collectionView.backgroundColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

   /* func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return array.count
    }
    
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:MainStoryCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainStoryCell
        
       let imageView = UIImageView()
        
        imageView.kf_setImageWithURL(NSURL(string: array[indexPath.row].photo)!, placeholderImage: nil, optionsInfo: nil) { (image, error, cacheType, imageURL) -> () in
            
            
            cell.icon.image = image
            
        }
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect))
        let visibleIndex = collectionView.indexPathForItemAtPoint(visiblePoint)
        
       
        print(array.count)
        
        
        if (visibleIndex?.item) != nil{
            
             print(visibleIndex?.item)
            
            let photoUrl:String! = array[(visibleIndex?.item)!].photo
            
            self.mainImage.kf_setImageWithURL(NSURL(string:photoUrl)!, placeholderImage: UIImage(named: "bob"))
        }
        
        

        
        ///////adds a smooth fading effect to cells as they come into view
        cell.alpha = 0
        
        let delay = UInt64((arc4random() % 600 / 1000))
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ({() -> Void in
            
            UIView.animateWithDuration(0.3, animations:  ({
              
                cell.alpha = 1.0
                
            }))
            
        }))

        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath.item)
        
        
        
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }
    

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}
