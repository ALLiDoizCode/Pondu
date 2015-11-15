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
import FMMosaicLayout

private let reuseIdentifier = "StoryList"

class StoryListViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var array:[userData] = []
    var storyUser:theUser = theUser()
    
    override func viewWillAppear(animated: Bool) {
        
        SwiftEventBus.onMainThread(self, name: "updateStory") { notification in
            
            print("passing data\(notification.object)")
            
            self.array = notification.object as! [userData]
            
            self.collectionView.reloadData()
            
            print("this is teh first picture\(self.array[1].story)")
            
        }
        
        storyUser.theUsers()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let mosaicLayout = FMMosaicLayout()
        
        self.collectionView.collectionViewLayout = mosaicLayout
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
        let cell:StoryListCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! StoryListCell
        
        cell.name.text = array[indexPath.item].userName
        
        cell.theImage.kf_setImageWithURL(NSURL(string: array[indexPath.item].story)!, placeholderImage: UIImage(named: "bob"))
        
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
    
    
    //MARK: FMMosaicLayoutDelegate
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        
        return 2
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, mosaicCellSizeForItemAtIndexPath indexPath: NSIndexPath!) -> FMMosaicCellSize {
        
        return (indexPath.item % 2 == 0) ? FMMosaicCellSize.Big : FMMosaicCellSize.Small;
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let cell = sender as? StoryListCell, indexPath = self.collectionView.indexPathForCell(cell) {
            
            if segue.identifier == "Slide" {
                
                let destinationViewController = segue.destinationViewController as! StoryViewController
        
                
                let theData = array[indexPath.item] 
                
                var editedArray:[userData] = array
                
                editedArray.insert(theData, atIndex: 0)
               
                var newArray:[userData] = editedArray
                
                newArray.removeAtIndex(indexPath.item + 1)
                
                destinationViewController.array = newArray
                
                
                print("old array name \(array.last!.userName)")
                print("new arry name \(newArray.last!.userName)")
            }
        
        }
        
    }

}
