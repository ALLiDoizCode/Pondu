//
//  MainViewcontroller.swift
//  Pondu
//
//  Created by Jonathan Green on 11/10/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import PagingMenuController
import SwiftEventBus

class MainViewcontroller: UIViewController,PagingMenuControllerDelegate {

    var CommentBtn:UIButton!
    
    let discoverBoard:UIStoryboard = UIStoryboard(name: "Discover", bundle: nil)
    let homeBoard:UIStoryboard = UIStoryboard(name: "Home", bundle: nil)

    
    let options = PagingMenuOptions()
    let dropShadow = DropShadow()
    var discover:DiscoverViewController!
    var Favorite:FavoriteViewController!
    var home:HomeViewController!
    var Mainwall:BaseViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        
        SwiftEventBus.onMainThread(self, name:"Title") { (result) -> Void in
            
            
            
        }
        
        SwiftEventBus.onMainThread(self, name: "NavHide") { (result) -> Void in
            
            self.navigationController?.navigationBarHidden = true
            
            
            self.options.backgroundColor = UIColor.clearColor()
    
            
        }
        
        
        SwiftEventBus.onMainThread(self, name: "NavShow") { (result) -> Void in
            
            self.navigationController?.navigationBarHidden = false
            
           
            
        }
        
        createPostBtn()
    
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
        print(UIScreen.screens())

        UIApplication.sharedApplication().statusBarHidden = true
        
        let discoverBoard:UIStoryboard = UIStoryboard(name: "Discover", bundle: nil)
        
        //let homeBoard:UIStoryboard = UIStoryboard(name: "Home", bundle: nil)

        Mainwall = self.storyboard?.instantiateViewControllerWithIdentifier("MainWall") as! BaseViewController
        
        Favorite = self.storyboard?.instantiateViewControllerWithIdentifier("FavWall") as! FavoriteViewController
        
        discover = discoverBoard.instantiateViewControllerWithIdentifier("Discover") as! DiscoverViewController
        
        home = homeBoard.instantiateViewControllerWithIdentifier("Profile") as! HomeViewController
        
        let viewControllers = [Mainwall,Favorite,discover,home]
        
        options.backgroundColor = UIColor.lightGrayColor()
        
        if UIScreen.mainScreen().bounds.height <= 1136.0  {
            
            options.menuHeight = 20
            options.menuDisplayMode = .SegmentedControl
            options.scrollEnabled = true
            options.font = UIFont(name: "Avenir", size: 20)!
            options.selectedFont = UIFont(name: "Avenir", size: 20)!
            options.menuPosition = .Bottom
            options.menuItemMode = .RoundRect(radius: 0, horizontalPadding: 0, verticalPadding: 0, selectedColor: UIColor.darkGrayColor())
            let pagingMenuController = self.childViewControllers.first as! PagingMenuController
            pagingMenuController.delegate = self
            pagingMenuController.setup(viewControllers: viewControllers, options: options)
            
        }else{
            
            options.menuHeight = 40
            options.menuDisplayMode = .SegmentedControl
            options.scrollEnabled = false
            options.font = UIFont(name: "Avenir", size: 20)!
            options.selectedFont = UIFont(name: "Avenir", size: 20)!
            options.menuPosition = .Bottom
            options.menuItemMode = .RoundRect(radius: 0, horizontalPadding: 4, verticalPadding: 0.5, selectedColor: UIColor.groupTableViewBackgroundColor())
            let pagingMenuController = self.childViewControllers.first as! PagingMenuController
            pagingMenuController.delegate = self
            pagingMenuController.setup(viewControllers: viewControllers, options: options)
        }

        
    }
    
    func gotoCommetns(){
        
        self.performSegueWithIdentifier("comment", sender: self)
    }
    
    func createPostBtn(){
        
        CommentBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 18))
        CommentBtn.setImage(UIImage(named: "ColumPost"), forState: UIControlState.Normal)
        CommentBtn.addTarget(self, action: "gotoCommetns", forControlEvents: .TouchUpInside)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PagingMenuControllerDelegate
    
    func willMoveToMenuPage(page: Int) {
        
        switch page {
            
        case 0:

            self.navigationItem.title = "MainWall"
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(hue: 0.6111, saturation: 0.71, brightness: 0.97, alpha: 1.0) /* #4882f9 */]
            self.navigationController?.navigationBarHidden = false
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            
            
            self.navigationItem.rightBarButtonItems?.removeAll()
            self.navigationItem.leftBarButtonItems?.removeAll()
            createPostBtn()
            let comment = UIBarButtonItem(customView: CommentBtn)
            self.navigationItem.rightBarButtonItem = comment
          
            
        case 1:
            
            self.navigationItem.title = "Favorites"
            self.navigationController?.navigationBarHidden = false
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            
            self.navigationItem.rightBarButtonItems?.removeAll()
            self.navigationItem.leftBarButtonItems?.removeAll()
            createPostBtn()
            let comment = UIBarButtonItem(customView: CommentBtn)
            self.navigationItem.rightBarButtonItem = comment
           
            
        case 2:
            
            
            /*let cameraBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            let messageBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            
            cameraBtn.addTarget(self, action: "cameraSelected", forControlEvents: .TouchUpInside)
            cameraBtn.setImage(UIImage(named: "camera"), forState: .Normal)
            
            searchBtn.addTarget(self, action: "cameraSelected", forControlEvents: .TouchUpInside)
            searchBtn.setImage(UIImage(named: "Search"), forState: .Normal)
            
            messageBtn.addTarget(self, action: "messages", forControlEvents: .TouchUpInside)
            messageBtn.setImage(UIImage(named: "message-1"), forState: .Normal)

            let camera = UIBarButtonItem(customView: cameraBtn)
            let search = UIBarButtonItem(customView: searchBtn)
            let message = UIBarButtonItem(customView: messageBtn)
            
            self.navigationItem.title = "Discover"
            self.navigationController?.navigationBarHidden = false
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.navigationItem.rightBarButtonItems = [search,camera]
            self.navigationItem.leftBarButtonItem = message*/
            
            self.navigationController?.navigationBarHidden = true
            
            
        case 3:
            
            self.navigationItem.title = "Home"
            self.navigationController?.navigationBarHidden = true
            
        default: break
        }
    }
    
    func didMoveToMenuPage(page: Int) {
    }
    
    
    func cameraSelected(){
        
        print("Camera")
        self.discover.performSegueWithIdentifier("camera", sender: self)
    }
    
    func searchSelected(){
        
        print("Search")
    }
    
    func messages(){
        
        self.discover.performSegueWithIdentifier("Messages", sender: self)
        
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
