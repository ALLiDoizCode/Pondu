//
//  FavoriteViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/10/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import PagingMenuController

class FavoriteViewController: UIViewController,PagingMenuControllerDelegate {

    @IBOutlet weak var post: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        UIApplication.sharedApplication().statusBarHidden = true
    
        let Events = self.storyboard?.instantiateViewControllerWithIdentifier("FavEvents") as! FavEventsViewController
        
        let Party = self.storyboard?.instantiateViewControllerWithIdentifier("FavParty") as! FavPartiesViewController
        
        let Story = self.storyboard?.instantiateViewControllerWithIdentifier("FavListStory") as! FavStoryListViewController
        
        Events.title = "Events"
        Party.title = "Parties"
        Story.title = "Stories"
        
        let viewControllers = [Events,Party,Story]
        
        let options = PagingMenuOptions()
        options.menuHeight = 30
        options.menuDisplayMode = .SegmentedControl
        options.font = UIFont(name: "Avenir", size: 20)!
        options.selectedFont = UIFont(name: "Avenir", size: 20)!
        options.menuItemMode = .RoundRect(radius: 2, horizontalPadding: 4, verticalPadding: 1, selectedColor: UIColor.clearColor())
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
    }
    
    @IBAction func postBtn(sender: AnyObject) {
        
        self.performSegueWithIdentifier("post", sender: self)
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
