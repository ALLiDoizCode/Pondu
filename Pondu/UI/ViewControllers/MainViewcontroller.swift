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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UIScreen.screens())

        UIApplication.sharedApplication().statusBarHidden = true

        let Mainwall = self.storyboard?.instantiateViewControllerWithIdentifier("MainWall") as! BaseViewController
        
        let Favorite = self.storyboard?.instantiateViewControllerWithIdentifier("FavWall") as! FavoriteViewController
        
       // let Story = self.storyboard?.instantiateViewControllerWithIdentifier("Story") as! StoryViewController
        
        let viewControllers = [Mainwall,Favorite]
        
        let options = PagingMenuOptions()
        
        if UIScreen.mainScreen().bounds.height <= 1136.0  {
            
            options.menuHeight = 30
            options.menuDisplayMode = .SegmentedControl
            options.scrollEnabled = false
            options.font = UIFont(name: "Avenir", size: 20)!
            options.selectedFont = UIFont(name: "Avenir", size: 20)!
            options.menuPosition = .Bottom
            options.menuItemMode = .RoundRect(radius: 2, horizontalPadding: 4, verticalPadding: 4, selectedColor: UIColor.grayColor())
            let pagingMenuController = self.childViewControllers.first as! PagingMenuController
            pagingMenuController.delegate = self
            pagingMenuController.setup(viewControllers: viewControllers, options: options)
            
        }else{
            
            options.menuHeight = 60
            options.menuDisplayMode = .SegmentedControl
            options.scrollEnabled = false
            options.font = UIFont(name: "Avenir", size: 20)!
            options.selectedFont = UIFont(name: "Avenir", size: 20)!
            options.menuPosition = .Bottom
            options.menuItemMode = .RoundRect(radius: 2, horizontalPadding: 4, verticalPadding: 4, selectedColor: UIColor.grayColor())
            let pagingMenuController = self.childViewControllers.first as! PagingMenuController
            pagingMenuController.delegate = self
            pagingMenuController.setup(viewControllers: viewControllers, options: options)
        }

        
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
