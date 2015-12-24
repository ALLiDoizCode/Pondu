//
//  SearchViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/23/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    let identifier = "Search"
    
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 300, 20))
    var searchBtn:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBtn = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "toggleSearch")
        self.navigationItem.leftBarButtonItem = searchBtn
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleSearch(){
        
        if searchBar.hidden == true {
            
            searchBar.hidden = false
            self.navigationItem.leftBarButtonItem = nil
            
        }else {
            
            searchBar.delegate = self
            searchBar.showsCancelButton = true
            searchBar.placeholder = "Your placeholder"
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
