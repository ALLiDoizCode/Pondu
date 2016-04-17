//
//  SearchViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/23/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftEventBus

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let identifier = "Search"
    let identifier2 = "camera"
    
    var users:[userData] = []
    var filtered:[userData] = []
    var follows:[String] = []
    
    var searchActive : Bool = false
    
    let presenter = theUser()
    let room = PresentMessage()
    
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 300, 20))
    
    var searchBtn:UIBarButtonItem!
    var cameraRightBtn:UIBarButtonItem!
    var messageRightBtn:UIBarButtonItem!
    
    
    override func viewWillAppear(animated: Bool) {
        
        presenter.myFollow { (data) -> Void in
            
            print("getting follows")
            
            self.follows.removeAll()
            self.follows = data
            self.reload()
        }
        
        searchActive = false
        
        self.users.removeAll()
        
        /*presenter.getUsers { (usersInfo) -> Void in
            
            self.users = usersInfo
            
            print("we have \(self.users.count) users")
            
            self.reload()
        }*/
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
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
    
    //Mark searcbar Protocols
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        var tempArray:[String] = []
        var tempFilter:[String] = []
        
        for var i = 0; i < users.count; i++ {
            
            tempArray.append(users[i].userName)
            
        }
        
        tempFilter = tempArray.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(tempFilter.count == 0){
            searchActive = false;
        } else {
            
            searchActive = true;
            
            filtered = []
            
            for var i = 0; i < tempFilter.count; i++ {
                
                for var j = 0; j < users.count; j++ {
                    
                    if tempFilter[i] == users[j].userName {
                        
                        filtered.append(users[j])
                    }
                    
                }
            }
        }
        
        self.reload()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive {
            
            return filtered.count;
            
        }else{
            
            return users.count;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! SearchCell
        
        if follows.contains(users[indexPath.row].objectID) {
            
            cell.add.setBackgroundImage(UIImage(named: "Checkmark"), forState: .Normal)
        }
        
        if searchActive {
            
            if filtered.count != 0 {
                
                print(filtered.count)
                cell.icon.kf_setImageWithURL(NSURL(string:filtered[indexPath.row].photo)!, placeholderImage: UIImage(named: "placeholder"))
                cell.label.text = filtered[indexPath.row].userName
                cell.objectId = users[indexPath.row].objectID
            }
            
        }else {
            
            cell.icon.kf_setImageWithURL(NSURL(string:users[indexPath.row].photo)!, placeholderImage: UIImage(named: "placeholder"))
            cell.label.text = users[indexPath.row].userName
            cell.objectId = users[indexPath.row].objectID
        }
        
        return cell;
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "room" {
            
            print("room made")
            
            let controller = segue.destinationViewController as! ChatViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow
            
            /* if searchActive {
                
                room.makeRoom((PFUser.currentUser()?.objectId)!, recipient: filtered[(indexPath?.row)!].objectID, completion: { (data) -> Void in
                    
                   print("user objectID \(self.filtered[(indexPath?.row)!].objectID)")
                    
                    controller.objectId = data
                })
                
             }else {
                
                room.makeRoom((PFUser.currentUser()?.objectId)!, recipient: users[(indexPath?.row)!].objectID, completion: { (data) -> Void in
                    
                    print("user objectID \(self.users[(indexPath?.row)!].objectID)")
                    
                    controller.objectId = data
                })
            }*/
            
        }
    }
    

}
