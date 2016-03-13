//
//  MessagesViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 1/29/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class MessagesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var myMessages:[MessageList]!
    
    let presenter = PresentMessage()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        
        presenter.getMessages { (data) -> Void in
            
            self.myMessages = data
            
            print("\( self.myMessages.count) Messages")
            
            self.reload()

        }
        
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func reload(){
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.myMessages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:MessagesCell = tableView.dequeueReusableCellWithIdentifier("Messages") as! MessagesCell
        
        cell.icon.kf_setImageWithURL(NSURL(string: self.myMessages[indexPath.row].icon)!, placeholderImage: UIImage(named: "placeholder"))
        
        cell.userName.text = self.myMessages[indexPath.row].name
        
        
        let date:NSDate = self.myMessages[indexPath.row].time
        
        let time = NSDate().offsetFrom(date)
        
        cell.time.text = time
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let index = tableView.indexPathForSelectedRow
        
        if segue.identifier == "message" {
            
            let controller = segue.destinationViewController as! ChatViewController
            
            //controller.data = self.myMessages[(index?.row)!].messages
            controller.objectId = self.myMessages[(index?.row)!].objectId
        }
    }
    
}
