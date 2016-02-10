//
//  SearchViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/23/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let identifier = "Search"
    let identifier2 = "camera"
    
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 300, 20))
    
    var searchBtn:UIBarButtonItem!
    var cameraRightBtn:UIBarButtonItem!
    var messageRightBtn:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let messageBtn = UIButton(frame: CGRectMake(0, 0, 20, 20))
        let cameraBtn = UIButton(frame: CGRectMake(0, 0, 30, 30))
        
        messageBtn.setImage(UIImage(named: "bubble"), forState: .Normal)
        messageBtn.addTarget(self, action: "message", forControlEvents: .TouchUpInside)
        cameraBtn.setImage(UIImage(named: "camera"), forState: .Normal)
        cameraBtn.addTarget(self, action: "camera", forControlEvents: .TouchUpInside)
        
        searchBtn = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "toggleSearch")
        cameraRightBtn = UIBarButtonItem(customView: cameraBtn)
        messageRightBtn = UIBarButtonItem(customView: messageBtn)
        self.navigationItem.leftBarButtonItem = searchBtn
        self.navigationItem.setRightBarButtonItems([cameraRightBtn,messageRightBtn], animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func reload(){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.tableView.reloadData()
            
        });
    }
    
    func camera(){
        
        self.performSegueWithIdentifier(identifier2, sender: self)
    }
    
    func message(){
        
    }
    
    func toggleSearch(){
        
        if searchBar.hidden == true {
            
            searchBar.hidden = false
            self.navigationItem.leftBarButtonItem = nil
            
        }else {
            
            searchBar.delegate = self
            searchBar.showsCancelButton = true
            searchBar.placeholder = "Looking for someone"
            self.navigationItem.titleView = searchBar
            self.navigationItem.leftBarButtonItem = nil
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! SearchCell
        
    
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
     
    }
    
    //Mark searbar delgate protocol
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        searchBar.hidden = true
        searchBar.resignFirstResponder()
        self.navigationItem.leftBarButtonItem = searchBtn
        
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
