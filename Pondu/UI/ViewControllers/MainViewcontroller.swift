//
//  MainViewcontroller.swift
//  Pondu
//
//  Created by Jonathan Green on 11/10/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import PagingMenuController

class MainViewcontroller: UIViewController,PagingMenuControllerDelegate {

    @IBOutlet weak var CommentBtn: UIBarButtonItem!
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let homeBoard:UIStoryboard = UIStoryboard(name: "Home", bundle: nil)

        let Mainwall = self.storyboard?.instantiateViewControllerWithIdentifier("MainWall") as! BaseViewController
        
        let Favorite = self.storyboard?.instantiateViewControllerWithIdentifier("FavWall") as! FavoriteViewController
        
        let discover = discoverBoard.instantiateViewControllerWithIdentifier("Search") as! SearchViewController
        
        let home = homeBoard.instantiateViewControllerWithIdentifier("Profile") as! HomeViewController
        
        let viewControllers = [Mainwall,Favorite,discover,home]
        
        let options = PagingMenuOptions()
        
        options.backgroundColor = UIColor.lightGrayColor()
        
        if UIScreen.mainScreen().bounds.height <= 1136.0  {
            
            options.menuHeight = 20
            options.menuDisplayMode = .SegmentedControl
            options.scrollEnabled = true
            options.font = UIFont(name: "Avenir", size: 20)!
            options.selectedFont = UIFont(name: "Avenir", size: 20)!
            options.menuPosition = .Bottom
            options.menuItemMode = .RoundRect(radius: 0, horizontalPadding: 4, verticalPadding: 0.5, selectedColor: UIColor.darkGrayColor())
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
    
    func createPostBtn(){
        
        button.setImage(UIImage(named: "ColumPost"), forState: UIControlState.Normal)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PagingMenuControllerDelegate
    
    func willMoveToMenuPage(page: Int) {
    }
    
    func didMoveToMenuPage(page: Int) {
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
