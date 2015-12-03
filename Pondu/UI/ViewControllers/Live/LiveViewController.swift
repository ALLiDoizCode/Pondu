//
//  LiveViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher


class LiveViewController: UIViewController,PlayerDelegate {
    
    var player:Player!
    var testImage:String!
    var testVideo:String!
    var imageViewObject:UIImageView!

    let imageTypes:[String] = ["jpg","jpeg","png","tiff","tif"]
    let videoTypes:[String] = ["mov","mp4", "m4v","3gp"]
    let comments:[String] = ["asdasdasdsadasdasdasdsadasdasdasdasdasdasdasdasdsadasasdasdasdsadasdasdasdasdasdasdasdasdsadasasdasdasdsadasdasdasdasdasdasdasdasdsadasasdasdasdsadasdasdasdasdasdasdasdasdsadasasdasdasdasdasdasdasdasdsadas comment", "more comments", "3rd test commemnt"]
    
    var fileArray:[String]!
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let tapRect = UITapGestureRecognizer()
    
    var fileCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        player = Player()
        player.delegate = self
        
        imageViewObject = UIImageView(frame:self.view.frame);
        
        tapRect.addTarget(self, action: "tappedView:")
        tapRect.numberOfTapsRequired = 1
        tapRect.numberOfTouchesRequired = 1
        self.view!.addGestureRecognizer(tapRect)
        
        fileArray = [testImage,testVideo]
        
        getFileType(fileArray[0])

    }
    
    
    func tappedView(sender:UITapGestureRecognizer) {
       
        if fileCount < fileArray.count {
            getFileType(fileArray[fileCount])
            fileCount++
        }
        
    }
    
    
    /*override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        let orientation: UIInterfaceOrientationMask = [UIInterfaceOrientationMask.Landscape, UIInterfaceOrientationMask.LandscapeLeft]
        return orientation
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func isImage(image:String){
        
        if player.view.hidden == false {
            
            player.view.hidden = true
            player.stop()
            
            print("got image \(image)")
            
            imageViewObject.kf_setImageWithURL(NSURL(string:image)!, placeholderImage: UIImage(named: "placeholder"))
            imageViewObject.contentMode = .ScaleAspectFill
            self.view.addSubview(imageViewObject)
        }else {
            
            print("got image \(image)")
            
            imageViewObject = UIImageView(frame:self.view.frame);
            imageViewObject.kf_setImageWithURL(NSURL(string:image)!, placeholderImage: UIImage(named: "placeholder"))
            imageViewObject.contentMode = .ScaleAspectFill
            self.view.addSubview(imageViewObject)
        }
        
        
        
    }
    
    
    func isVideo(video:String){
        
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
        self.interfaceOrientation.isLandscape
        
        if imageViewObject.hidden == false {
            
            imageViewObject.hidden = true
            
            player.view.frame = self.view.bounds
            
            self.addChildViewController(self.player)
            self.view.addSubview(self.player.view)
            self.player.didMoveToParentViewController(self)
            
            self.player.setUrl(NSURL(string: video)!)
            
            self.player.playbackLoops = true
            
            
            //let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTapGestureRecognizer:")
            //tapGestureRecognizer.numberOfTapsRequired = 1
            //self.player.view.addGestureRecognizer(tapGestureRecognizer)
            
            self.player.playFromBeginning()
        }else {
            
            player = Player()
            player.delegate = self
            player.view.frame = self.view.bounds
            
            self.addChildViewController(self.player)
            self.view.addSubview(self.player.view)
            self.player.didMoveToParentViewController(self)
            
            self.player.setUrl(NSURL(string: video)!)
            
            self.player.playbackLoops = true
            
            
            //let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTapGestureRecognizer:")
            //tapGestureRecognizer.numberOfTapsRequired = 1
            //self.player.view.addGestureRecognizer(tapGestureRecognizer)
            
            self.player.playFromBeginning()
        }
        
      
        
    }
    
    func getFileType(thefile:String){
        
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
            
            isVideo(thefile)
            //print(fileType)
            print(thefile)
        }else{
            
            isImage(thefile)
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
    

    
    @IBAction func sendBtn(sender: AnyObject) {
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


