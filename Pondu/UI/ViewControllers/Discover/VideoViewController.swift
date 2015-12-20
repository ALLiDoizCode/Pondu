//
//  VideoViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/20/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController,PlayerDelegate {
    
    
        var player:Player!
        var videoUrl:NSURL!
    
    let tapRect = UITapGestureRecognizer()
    let swipeDownRect = UISwipeGestureRecognizer()
    let swipeRightRect = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapRect.addTarget(self, action: "tappedView:")
        tapRect.numberOfTapsRequired = 1
        tapRect.numberOfTouchesRequired = 1
        self.view!.addGestureRecognizer(tapRect)
        
        
        swipeDownRect.addTarget(self, action: "swippedDown:")
        swipeDownRect.numberOfTouchesRequired = 1
        swipeDownRect.direction = .Down
        self.view!.addGestureRecognizer(swipeDownRect)
        
        player = Player()
        player.delegate = self
        
        player.view.frame = self.view.frame
        
        self.addChildViewController(self.player)
        self.view.addSubview(self.player.view)
        self.player.didMoveToParentViewController(self)
        
        self.player.setUrl(videoUrl)
        
        self.player.playbackLoops = true
        
        self.player.playFromBeginning()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedView(sender:UITapGestureRecognizer) {
        
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
    
    func swippedDown(sender:UISwipeGestureRecognizer) {
        
        player.stop()
        self.performSegueWithIdentifier("Home", sender: self)
        
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
