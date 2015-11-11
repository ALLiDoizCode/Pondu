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
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.array.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:StoryCell = collectionView.dequeueReusableCellWithReuseIdentifier("StoryCell", forIndexPath: indexPath) as! StoryCell
        
       cell.userIcon.kf_setImageWithURL(NSURL(string: array[indexPath.item].photo)!, placeholderImage: UIImage(named: "bob"))
        
        cell.name.text = array[indexPath.item].fullName
        
        load_image(cell.motionView,item: indexPath.item)
        
        print(array[indexPath.item].story)
        
        print(array[indexPath.item])
        
        return cell
        
    }
    
    
    func load_image(view:PanoramaView,item:Int) {
        
        let imgURL: NSURL = NSURL(string: array[item].story)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response,data,error) -> Void in
                if error == nil {
                    
                    
                    view.setImage(UIImage(data: data!)!)
                    
                    
                }
        })
        
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
