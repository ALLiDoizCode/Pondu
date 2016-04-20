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
    
    @IBOutlet weak var goBack: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let identifier = "Search"
    let identifier2 = "camera"
    let tapBack = UITapGestureRecognizer()
    
    var users:[UserInfo] = []
    var filtered:[UserInfo] = []
    var follows:[String] = []
    
    var searchActive : Bool = false
    
    let presenter = theUser()
    let room = PresentMessage()
    let presenterFile = PresentMainWall()
    
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
        
        presenter.getUsers { (usersInfo) -> Void in
            
            self.users = usersInfo
            
            print("we have \(self.users.count) users")
            print(self.users[0].userName)
            print(self.users[0].profileImage)
            
            self.reload()
        }
        
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
        
        goBack.userInteractionEnabled = true
        goBack.addGestureRecognizer(tapBack)
        tapBack.addTarget(self, action: #selector(SearchViewController.tappedBack(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedBack(sender:UITapGestureRecognizer) {
        
        self.performSegueWithIdentifier("goBack", sender: self)
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
        
        for i in 0 ..< users.count {
            
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
            
            for i in 0 ..< tempFilter.count {
                
                for j in 0 ..< users.count {
                    
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
        
        if follows.contains(users[indexPath.row].userName) {
            
            cell.add.setBackgroundImage(UIImage(named: "Checkmark"), forState: .Normal)
        }
        
        if searchActive {
            
            if filtered.count != 0 {
                
                print(filtered.count)
                
                presenterFile.getFile(filtered[indexPath.row].profileImage, completion: { (data) in
                    
                    cell.icon.kf_setImageWithURL(data, placeholderImage: UIImage(named: "placeholder"))

                })
                
                cell.label.text = filtered[indexPath.row].userName
                cell.userName = cell.label.text
            }
            
        }else {
            
            presenterFile.getFile(users[indexPath.row].profileImage, completion: { (data) in
                
                cell.icon.kf_setImageWithURL(data, placeholderImage: UIImage(named: "placeholder"))
                
            })
            
            cell.label.text = users[indexPath.row].userName
            cell.userName = cell.label.text
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
            
            if searchActive {
                
                controller.recipient = filtered[indexPath!.row].userName
                
             }else {
                
                controller.recipient = users[indexPath!.row].userName
        
            }
            
        }
    }
    

}
