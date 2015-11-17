//
//  FavStoryListViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/15/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Kingfisher

private let reuseIdentifier = "FavStoryCell"

class FavStoryListViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var iconView: StoryIconVIew!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var array:[userData] = []
    var storyUser:theUser = theUser()
    
    override func viewWillAppear(animated: Bool) {
      
        storyUser.getFavorite()
        
        self.iconView.layoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftEventBus.onMainThread(self, name: "updateFavStory") { notification in
            
            print("passing data\(notification.object)")
            
            self.array = notification.object as! [userData]
            
            self.collectionView.reloadData()
            
            print("this is teh first picture\(self.array[1].story)")
            
        }
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
        let cell:FavoriteStoryCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FavoriteStoryCell
        
        let imageView = UIImageView()
        
        imageView.kf_setImageWithURL(NSURL(string: array[indexPath.row].photo)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil) { (image, error, cacheType, imageURL) -> () in
            
            
            cell.icon.image = image
            
        }
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect))
        let visibleIndex = collectionView.indexPathForItemAtPoint(visiblePoint)
        
        print(array.count)
        
        if (visibleIndex?.item) != nil{
            
            print(visibleIndex?.item)
            
            let photoUrl:String! = array[(visibleIndex?.item)!].photo
            
            self.mainImage.kf_setImageWithURL(NSURL(string: photoUrl)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                
                self.iconView.subImage.image = image
            })
            
            self.iconView.name.text = array[(visibleIndex?.item)!].userName
            
        }else if let photoUrl:String! = array[0].photo {
            
                self.mainImage.kf_setImageWithURL(NSURL(string: photoUrl)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                    
                    self.iconView.subImage.image = image
                })
                
                self.iconView.name.text = array[0].userName
        }else {
            
            let placeHolder = UIImage(named: "placeholder")
            
            self.mainImage.image = placeHolder
            self.iconView.subImage.image = placeHolder
            self.iconView.name.text = ""
        }
        
        
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
        
        let photoUrl:String! = array[(indexPath.item)].photo
        
        self.mainImage.kf_setImageWithURL(NSURL(string: photoUrl)!, placeholderImage: UIImage(named: "bob"), optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
            
            self.iconView.subImage.image = image
        })
        
        self.iconView.name.text = array[(indexPath.item)].userName

        
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
