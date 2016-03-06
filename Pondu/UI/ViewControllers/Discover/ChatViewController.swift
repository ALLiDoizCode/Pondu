//
//  ChatViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 3/4/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher
import Parse
import SwiftEventBus

class ChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    
    var data:[Message] = []
    var objectId:String!
    
    let currentUser = PFUser.currentUser()
    let dropShawdow = DropShadow()
    let presenter = PresentMessage()
    let theCloud = Cloud()
    
    override func viewWillAppear(animated: Bool) {
        
        print("msg id is \(objectId)")
        
        theCloud.addChannel(objectId)
        
        self.presenter.messageWithId(self.objectId, completion: { (msgData) -> Void in
            
            self.data = msgData
            
            self.reload()
            
            self.textField.text = ""
            
            print("Reloaded Messges")
            
            print("we have \(self.data.count) messages")
            
        })
        
        self.navigationController?.navigationBarHidden = true
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        theCloud.removeChannel(objectId)
        
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftEventBus.onBackgroundThread(self, name: "New") { result in
            
            print("incoming push")
            
            self.presenter.messageWithId(self.objectId, completion: { (msgData) -> Void in
                
                self.data = msgData
                
                self.reload()
                
                
                
                self.textField.text = ""
                
                print("Reloaded Messges")
                
                print("we have \(self.data.count) messages")
                
            })
        }
        
        dropShawdow.shadow(navView, color: UIColor.darkGrayColor())

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollToBottom(animated: Bool = true) {
        let sections = self.tableView.numberOfSections
        let rows = self.tableView.numberOfRowsInSection(sections - 1)
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: rows - 1, inSection: sections - 1), atScrollPosition: .Bottom, animated: true)
    }
    
    @IBAction func send(sender: AnyObject) {
        
        if textField.text != "" {
            
            presenter.sendMessage(objectId, text: textField.text!) { () -> Void in
                
                print("sending push")
                
            }
            
            
        }
        
        self.theCloud.pushComment(self.objectId,type: "msg")
    }
    
    @IBAction func camera(sender: AnyObject) {
        
    }
    
    func reload(){
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.tableView.reloadData()
            
            self.scrollToBottom(true)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell") as! ChatCell
        
        cell.message.text = data[indexPath.row].description
        cell.userName.text = data[indexPath.row].sender
        
        let date:NSDate = self.data[indexPath.row].date
        let time = NSDate().offsetFrom(date)
        
        cell.time.text = time
        
        if data[indexPath.row].sender != currentUser?.username {
            
            cell.bar.image = UIImage(named: "msgred")
            cell.userName.textColor = UIColor.lightGrayColor()
        }
        
        return cell
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
