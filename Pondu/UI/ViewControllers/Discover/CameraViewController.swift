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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.camera.start()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenRect = UIScreen.mainScreen().bounds
        
        self.camera = LLSimpleCamera(quality: AVCaptureSessionPresetHigh, position: LLCameraPositionRear, videoEnabled: true)
        
        self.camera.attachToViewController(self, withFrame: CGRectMake(0, 0, screenRect.size.width, screenRect.size.height))
        
       capturePhoto()
        
        //captureVideo()

        // Do any additional setup after loading the view.
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
        
       self.camera.start()
        
    }
    
    func stopRecording(){
        
        self.camera.stopRecording { (camera, url, error) -> Void in
            
            print(url)
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
