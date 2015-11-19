//
//  BaseViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/6/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import PagingMenuController


class BaseViewController: UIViewController,PagingMenuControllerDelegate {
    
    let userLogin = startLogin()
    
    override func viewDidLoad() {
         userLogin.beginLogin("bob", password: "password")
        
        UIApplication.sharedApplication().statusBarHidden = true
        super.viewDidLoad()
        let Events = self.storyboard?.instantiateViewControllerWithIdentifier("Events") as! ViewController
        
        let Party = self.storyboard?.instantiateViewControllerWithIdentifier("Party") as! PartyViewController
        
        let Story = self.storyboard?.instantiateViewControllerWithIdentifier("StoryListView") as! StoryListViewController
        
        let viewControllers = [Events,Party,Story]
        
        let options = PagingMenuOptions()
        options.menuHeight = 40
        options.menuDisplayMode = .SegmentedControl
        options.font = UIFont(name: "Avenir", size: 20)!
        options.selectedFont = UIFont(name: "Avenir", size: 20)!
        options.menuItemMode = .RoundRect(radius: 2, horizontalPadding: 4, verticalPadding: 4, selectedColor: UIColor.grayColor())
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
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
