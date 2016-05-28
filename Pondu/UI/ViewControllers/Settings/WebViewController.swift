//
//  WebViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 5/27/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

import Material
import Cartography
import SwiftEventBus

class WebViewController: UIViewController,UIWebViewDelegate {
    
    var backBtn:MaterialButton!
    var topView:UIView!
    var webV:UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn = MaterialButton()
        topView = UIView()
        webV = UIWebView()
        webV.loadRequest(NSURLRequest(URL: NSURL(string: "http://pondu-app.com/")!))
        webV.delegate = self
        self.view.addSubview(webV)
        self.view.addSubview(topView)
        self.topView.addSubview(backBtn)
        
        self.backBtn.setImage(UIImage(named:"arrows"), forState: UIControlState.Normal)
        self.backBtn.addTarget(self, action: "cancleBtn", forControlEvents: UIControlEvents.TouchUpInside)
        
        constrain(backBtn,topView,webV) { backBtn,topView,webV in
            
            topView.top == (topView.superview?.top)!
            topView.left == (topView.superview?.left)!
            topView.height == (topView.superview?.height)! * 0.07
            topView.width == (topView.superview?.width)!
            
            backBtn.left == (backBtn.superview?.left)! + 5
            backBtn.centerY == (backBtn.superview?.centerY)!
            backBtn.width == 25
            backBtn.height == 25
            
            webV.left == (webV.superview?.left)!
            webV.width == (webV.superview?.width)!
            webV.bottom == (webV.superview?.bottom)!
            webV.top == topView.bottom
            
        }


        // Do any additional setup after loading the view.
    }
    
    func goHome(){
        
        let mainStorybord = UIStoryboard(name: "Main", bundle: nil)
        let mainViewcontroller = mainStorybord.instantiateViewControllerWithIdentifier("Base")
        SwiftEventBus.post("Home", sender: 4)
        self.navigationController?.pushViewController(mainViewcontroller, animated: true)
    }
    
    func cancleBtn() {
        
        goHome()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("Webview fail with error \(error)");
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    func webViewDidStartLoad(webView: UIWebView) {
        print("Webview started Loading")
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        print("Webview did finish load")
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
