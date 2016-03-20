//
//  CameraViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/19/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import LLSimpleCamera
import CircleSlider
import FXBlurView


class CameraViewController: UIViewController {
    
    var camera:LLSimpleCamera!
    var snapButton:UIButton!
    var exit:UIButton!
    var flash:UIButton!
    var toggleCam:UIButton!
    var switchButton:UIButton! = UIButton()
    var circleSlider:CircleSlider!
    var circleProgress: CircleSlider!
    var timer:NSTimer!
    var progressValue:Float = 0
    var tapRect:UITapGestureRecognizer!
    var blurView:FXBlurView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.camera.start()
        self.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenRect = UIScreen.mainScreen().bounds
        
        self.camera = LLSimpleCamera(quality: AVCaptureSessionPresetHigh, position: LLCameraPositionRear, videoEnabled: true)
        
        self.camera.attachToViewController(self, withFrame: CGRectMake(0, 0, screenRect.size.width, screenRect.size.height))
        
        makeSnap()
        toggleCameraPosition()
        makeExit()
        makeFlash()
        makeToggle()
        makeBlur()
    }
    
    func makeSnap(){
        
        tapRect = UITapGestureRecognizer(target: self, action: "tap:")
        tapRect.numberOfTapsRequired = 1
        tapRect.numberOfTouchesRequired = 1
        
        self.snapButton = UIButton(type: .System)
        self.snapButton = UIButton(frame: CGRect(x: self.camera.view.frame.midX - 20, y:camera.view.frame.height - 60, width: 50, height: 50))
        self.snapButton.clipsToBounds = true
        self.snapButton.layer.cornerRadius = self.snapButton.frame.height/2
        self.snapButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.snapButton.layer.borderWidth = 2
        self.snapButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.snapButton.layer.rasterizationScale = UIScreen.mainScreen().scale
        self.snapButton.layer.shouldRasterize = true
        self.snapButton.addGestureRecognizer(tapRect)
        self.view.addSubview(self.snapButton)
    }
    
    func makeExit(){
        
        self.exit = UIButton(type: .System)
        self.exit = UIButton(frame: CGRect(x: self.view.frame.width - 40, y: 10.0, width: 20.0, height: 20.0))
        self.exit.setImage(UIImage(named: "x2"), forState: .Normal)
        self.view.addSubview(self.exit)
    }
    
    func makeFlash(){
        
        self.flash = UIButton(type: .System)
        self.flash = UIButton(frame: CGRect(x: 20, y: 10.0, width: 20.0, height: 20.0))
        self.flash.setImage(UIImage(named:"flash-off"), forState: .Normal)
        self.view.addSubview(self.flash)
    }
    
    func makeToggle(){
        
        self.toggleCam = UIButton(type: .System)
        self.toggleCam = UIButton(frame: CGRect(x: self.camera.view.frame.midX - 5, y: 10.0, width: 20.0, height: 20.0))
        self.toggleCam.setImage(UIImage(named:"camera-1"), forState: .Normal)
        self.toggleCam.layer.rasterizationScale = UIScreen.mainScreen().scale
        self.toggleCam.layer.shouldRasterize = true
        self.view.addSubview(self.toggleCam)
    }
    
    func makeBlur(){
        
        self.blurView = FXBlurView(frame: CGRect(x: 0, y: self.camera.view.frame.height, width: self.camera.view.frame.width, height: 40))
        self.blurView.blurRadius = 20
        self.blurView.blurEnabled = true
        self.blurView.backgroundColor = UIColor.blackColor()
        self.blurView.tintColor = UIColor.blackColor()
        self.camera.view.addSubview(self.blurView)
    }
    
    func tap(sender:UITapGestureRecognizer) {
        
        print("Tap happend")
        self.snapButton.addTarget(self, action: "capturePhoto", forControlEvents: .TouchUpInside)
    }
    
    func long() {
        
        print("Long press")
        self.snapButton.addTarget(self, action: "captureVideo", forControlEvents: .TouchUpInside)
    }
    
    func toggleCameraPosition(){
        
        if LLSimpleCamera.isFrontCameraAvailable() && LLSimpleCamera.isRearCameraAvailable() {
            
            //button that toggle camera postion
            
            self.switchButton = UIButton(type: .System)
            self.switchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 49, height: 49))
            self.switchButton.tintColor = UIColor.whiteColor()
            self.switchButton.setImage(UIImage(named:"switch"), forState: .Normal)
            self.switchButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 40, 40)
            self.switchButton.addTarget(self, action: "switchCam", forControlEvents: .TouchUpInside)
            self.switchButton.contentMode = .ScaleAspectFill
            self.view.addSubview(self.switchButton)
            
        }
    }
    
    func switchCam(){
        
        self.camera.togglePosition()
        
    }
    
    func capturePhoto(){
        self.camera.capture { (camera, image, data, error) -> Void in
            
            if error == nil {
                // we should stop the camera, since we don't need it anymore. We will open a new vc.
                // this very important, otherwise you may experience memory crashes
                
               
                
                //show the image
                
                self.performSegueWithIdentifier("image", sender: image)
                camera.stop()
                
               
            }
        }
    }
    
    func captureVideo(){
        
        if self.camera.recording != true {
            
            snapButton.layer.borderColor = UIColor.clearColor().CGColor
            snapButton.layer.borderWidth = 0
           // circle()
           // progress()
            
            switchButton.hidden = true
            
            let outputUrl = self.applicationDocumentsDirectory().URLByAppendingPathComponent("test").URLByAppendingPathExtension("mov")
            
            self.camera.startRecordingWithOutputUrl(outputUrl)
        }else {
            
            switchButton.hidden = false
            
            stopRecording()
        }
        
        
        
       
        
    }
    
    func stopRecording(){
        
        self.camera.stopRecording { (camera, url, error) -> Void in
            
           self.performSegueWithIdentifier("video", sender: url)
        }
    }
    
    func applicationDocumentsDirectory() -> NSURL {
        
       return NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last!
    }
    
   /* func circle(){
        
        let purple = UIColor.purpleColor()
        
        var sliderOptions: [CircleSliderOption] {
            return [
                .BarColor(UIColor(red: 255/255, green: 190/255, blue: 190/255, alpha: 0.3)),
                .ThumbColor(UIColor(red: 141/255, green: 185/255, blue: 204/255, alpha: 1)),
                .TrackingColor(purple),
                .BarWidth(4),
                .StartAngle(-45),
                .MaxValue(250),
                .MinValue(0)
            ]
        }
        
        self.circleSlider = CircleSlider(frame: CGRect(x: self.view.layer.frame.midX - 30, y:400, width: 70, height: 70), options: sliderOptions)
        //self.circleSlider?.addTarget(self, action: Selector("valueChange:"), forControlEvents: .ValueChanged)
        self.view.addSubview(self.circleSlider!)
      
        
    }*/
    
    
    /*func buildCircleProgress() {
        
        let purple = UIColor.purpleColor()
        
        var progressOptions: [CircleSliderOption] {
            return [
                .BarColor(UIColor(red: 141/255, green: 185/255, blue: 204/255, alpha: 1)),
                .TrackingColor(UIColor(red: 141/255, green: 185/255, blue: 204/255, alpha: 1)),
                .BarWidth(20),
                .SliderEnabled(false)
            ]
        }
        
            self.circleProgress = CircleSlider(frame: CGRect(x: self.view.layer.frame.midX - 30, y:400, width: 70, height: 70), options: progressOptions)
            //self.circleProgress?.addTarget(self, action: Selector("valueChange:"), forControlEvents: .ValueChanged)
            self.view.addSubview(self.circleProgress!)
        }
    
    func progress(){
        
        if self.timer == nil {
            self.progressValue = 0
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: Selector("fire:"), userInfo: nil, repeats: true)
        }
    }
    
    func fire(timer: NSTimer) {
        self.progressValue = progressValue + 0.5
        /*if self.progressValue > 100 {
            self.timer?.invalidate()
            self.timer = nil
            self.progressValue = 0
        }*/
        self.circleSlider.value = self.progressValue
    }*/
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "video" {
            
            let controller = segue.destinationViewController as! VideoViewController
            controller.videoUrl = sender as! NSURL
            
        }
        if segue.identifier == "image" {
            
            let controller:ImageViewController = segue.destinationViewController as! ImageViewController
            controller.theImage = sender as! UIImage
        }
    }


}
