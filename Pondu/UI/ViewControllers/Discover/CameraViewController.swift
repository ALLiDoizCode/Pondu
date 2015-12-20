//
//  CameraViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/19/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import LLSimpleCamera


class CameraViewController: UIViewController {
    
    
    
    var camera:LLSimpleCamera!
    var snapButton:UIButton!
    var switchButton:UIButton!
    
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
    }
    
    func makeSnap(){
        
        self.snapButton = UIButton(type: .System)
        self.snapButton = UIButton(frame: CGRect(x: self.view.layer.frame.midX - 30, y:400, width: 70, height: 70))
        self.snapButton.clipsToBounds = true
        self.snapButton.layer.cornerRadius = self.snapButton.frame.height/2
        self.snapButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.snapButton.layer.borderWidth = 2
        self.snapButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.snapButton.layer.rasterizationScale = UIScreen.mainScreen().scale
        self.snapButton.layer.shouldRasterize = true
        self.snapButton.addTarget(self, action: "captureVideo", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.snapButton)
    }
    
    func toggleCameraPosition(){
        
        if LLSimpleCamera.isFrontCameraAvailable() && LLSimpleCamera.isRearCameraAvailable() {
            
            //button that toggl camera postion
            
            self.switchButton = UIButton(type: .System)
            self.switchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 49, height: 49))
            self.switchButton.tintColor = UIColor.whiteColor()
            self.switchButton.setImage(UIImage(named:"switch"), forState: .Normal)
            self.switchButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
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
                
                //camera.stop()
                
                //show the image
               
            }
        }
    }
    
    func captureVideo(){
        
        let outputUrl = self.applicationDocumentsDirectory().URLByAppendingPathComponent("test").URLByAppendingPathExtension("mov")
        
       self.camera.startRecordingWithOutputUrl(outputUrl)
        
    }
    
    func stopRecording(){
        
        self.camera.stopRecording { (camera, url, error) -> Void in
            
            print(url)
        }
    }
    
    func applicationDocumentsDirectory() -> NSURL {
        
       return NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last!
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
