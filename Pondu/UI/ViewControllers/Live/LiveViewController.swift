//
//  LiveViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class LiveViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,PlayerDelegate {
    
    var player:Player!
    
    var testImage:String!
    var testVideo:String!
    
    
    let imageTypes:[String] = ["jpg","jpeg","png","tiff","tif"]
    let videoTypes:[String] = ["mov","mp4", "m4v","3gp"]
    
    var fileArray:[String]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fileArray = [testImage,testVideo]
        
        print(testImage)
        
        collectionView.reloadData()

    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return fileArray.count
    }
    

   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:LiveCell = collectionView.dequeueReusableCellWithReuseIdentifier("LiveCell", forIndexPath: indexPath) as! LiveCell
        
        //cell.contentView.backgroundColor = UIColor.blueColor()
        
        /*var imageViewObject:UIImageView!
        imageViewObject = UIImageView(frame:cell.contentView.frame);
        imageViewObject.kf_setImageWithURL(NSURL(string:testImage)!, placeholderImage: UIImage(named: "placeholder"))
        cell.contentView.addSubview(imageViewObject)*/
        
       

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        
         getFileType(fileArray[indexPath.item],cell: cell as! LiveCell)
        
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func isImage(image:String,cell:LiveCell){
        
        print("got image \(image)")
        
        var imageViewObject:UIImageView!
        imageViewObject = UIImageView(frame:cell.contentView.frame);
        imageViewObject.kf_setImageWithURL(NSURL(string:image)!, placeholderImage: UIImage(named: "placeholder"))
        cell.contentView.addSubview(imageViewObject)
    }
    
    
    func isVideo(video:String,cell:LiveCell){
        
        player = Player()
        player.delegate = self
        player.view.frame = cell.contentView.bounds
        
        self.addChildViewController(self.player)
        cell.contentView.addSubview(self.player.view)
        self.player.didMoveToParentViewController(self)
        
        self.player.setUrl(NSURL(string: video)!)
        
        self.player.playbackLoops = true
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTapGestureRecognizer:")
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
    
        //self.player.playFromBeginning()
        
    }
    
    func getFileType(thefile:String,cell:LiveCell){
        
        var indexOfUrl:[Character] = []
        
        for i in thefile.characters {
            //print(i)
            
            indexOfUrl.append(i)
        }
        
        let letterIndex = indexOfUrl.count - 1
        
        let chac1 = indexOfUrl[letterIndex]
        let chac2 = indexOfUrl[letterIndex - 1]
        let chac3 = indexOfUrl[letterIndex - 2]
        
        let fileType = "\(chac3)\(chac2)\(chac1)"
        
        if (fileType == videoTypes[0]) || (fileType == videoTypes[1]) || (fileType == videoTypes[2]) || (fileType == videoTypes[3]) {
            
            isVideo(thefile,cell:cell)
            //print(fileType)
            print(thefile)
        }else{
            
            isImage(thefile,cell: cell)
            //print(fileType)
            print(thefile)

        }
        
       
    }
    
    // MARK: UIGestureRecognizer
    
    func handleTapGestureRecognizer(gestureRecognizer: UITapGestureRecognizer) {
        switch (self.player.playbackState.rawValue) {
        case PlaybackState.Stopped.rawValue:
            self.player.playFromBeginning()
        case PlaybackState.Paused.rawValue:
            self.player.playFromCurrentTime()
        case PlaybackState.Playing.rawValue:
            self.player.pause()
        case PlaybackState.Failed.rawValue:
            self.player.pause()
        default:
            self.player.pause()
        }
    }
    
    // MARK: PlayerDelegate
    
    func playerReady(player: Player) {
    }
    
    func playerPlaybackStateDidChange(player: Player) {
    }
    
    func playerBufferingStateDidChange(player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(player: Player) {
    }
    
    func playerPlaybackDidEnd(player: Player) {
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
