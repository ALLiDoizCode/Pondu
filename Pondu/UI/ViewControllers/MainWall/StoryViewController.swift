//
//  StoryViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/7/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Kingfisher


class StoryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var array:[user] = []
    var storyUser:theUser = theUser()
    

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(animated: Bool) {
        
        SwiftEventBus.onMainThread(self, name: "updateStory") { notification in
            
            print("passing data\(notification.object)")
            
            self.array = notification.object as! [user]
            
            self.collectionView.reloadData()
            
            print("this is teh first picture\(self.array[1].story)")
            
        }
        
        storyUser.theUsers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.array.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:StoryCell = collectionView.dequeueReusableCellWithReuseIdentifier("StoryCell", forIndexPath: indexPath) as! StoryCell
        
        let imageView = UIImageView()
        
            cell.userIcon.kf_setImageWithURL(NSURL(string: array[indexPath.item].photo)!, placeholderImage: UIImage(named: "bob"))
            
            cell.name.text = array[indexPath.item].fullName
        
            imageView.kf_setImageWithURL(NSURL(string: array[indexPath.item].story)!, placeholderImage: nil, optionsInfo: nil) { (image, error, cacheType, imageURL) -> () in
                
                let motionView = PanoramaView(frame: cell.Panaorama.bounds)
                motionView.setImage(imageView.image!)
                cell.Panaorama.addSubview(motionView)
                motionView.setScrollIndicatorEnabled(false)
            }

        return cell
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
