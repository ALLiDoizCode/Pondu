//
//  CommentViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 2/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftEventBus

class CommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let presenter = Comments()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var send: UIButton!
    
    var comments:[Comment] = []
    var objectId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.send.layer.cornerRadius = 3
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.title = "Comments"
        
        //SwiftEventBus.postToMainThread("Title", sender: "Comments")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
        presenter.getComments(objectId) { (data) -> Void in
            
            self.comments = data
            
            self.reload()
        }
    }
    
    
    
    @IBAction func sendBtn(sender: AnyObject) {
        
        guard let text:String = textField.text else {
            
            return
        }
        
        presenter.comment(objectId, description: text) { (success) -> Void in
            
            self.reload()
        }
    }
    
    func reload(){
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
         
            self.tableView.reloadData()
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CommentCell = tableView.dequeueReusableCellWithIdentifier("Comments") as! CommentCell
        
        cell.comment.text = comments[indexPath.row].description
        cell.userImage.kf_setImageWithURL(NSURL(string: comments[indexPath.row].creatorImage)!)
        cell.userName.text = comments[indexPath.row].creatorName
        
        return cell
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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