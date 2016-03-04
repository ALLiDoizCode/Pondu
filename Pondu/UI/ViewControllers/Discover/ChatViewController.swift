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

class ChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var navView: UIView!
    
    var data:[Message]!
    
    let currentUser = PFUser.currentUser()
    let dropShawdow = DropShadow()
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropShawdow.shadow(navView, color: UIColor.darkGrayColor())

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
