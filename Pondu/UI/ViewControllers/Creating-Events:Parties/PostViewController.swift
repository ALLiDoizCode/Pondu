//
//  PostViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/20/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import LTMorphingLabel
import SwiftEventBus

class PostViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var mainLabel: LTMorphingLabel!
    @IBOutlet weak var textVIew: UITextView!
    @IBOutlet weak var post: UIButton!
    
    let makeEvent = MakingEvent()
    let makeParty = MakingParty()
    
    let likes = 0
    let live = false
    var type:Bool!
    var wallType:Bool!
    var timeStart:String!
    var timeEnd:String!
    var date:String!
    var address:String!
    var lat:Double!
    var long:Double!
    var privacy:Bool!
    
    let PLACEHOLDER_TEXT = "Type here"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postDidFinish()
        
        self.title = "Post"
        
        textVIew.delegate = self
        mainLabel.text = "Write a post"
        mainLabel.morphingEffect = .Evaporate
        mainLabel.morphingDuration = 0.8
        mainLabel.numberOfLines = 0
        
        applyPlaceholderStyle(textVIew!, placeholderText: PLACEHOLDER_TEXT)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        textVIew.resignFirstResponder()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func applyPlaceholderStyle(aTextview: UITextView, placeholderText: String) {
        // make it look (initially) like a placeholder
        aTextview.textColor = UIColor.lightGrayColor()
        aTextview.text = placeholderText
    }
    
    func applyNonPlaceholderStyle(aTextview: UITextView) {
        // make it look like normal text instead of a placeholder
        aTextview.textColor = UIColor.darkTextColor()
        aTextview.alpha = 1.0
    }
    
    func textViewShouldBeginEditing(aTextView: UITextView) -> Bool {
        if aTextView == textVIew && aTextView.text == PLACEHOLDER_TEXT {
            // move cursor to start
            moveCursorToStart(aTextView)
        }
        return true
    }
    
    func moveCursorToStart(aTextView: UITextView) {
        dispatch_async(dispatch_get_main_queue(), {
            aTextView.selectedRange = NSMakeRange(0, 0);
        })
    }

    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        // remove the placeholder text when they start typing
        // first, see if the field is empty
        // if it's not empty, then the text should be black and not italic
        // BUT, we also need to remove the placeholder text if that's the only text
        // if it is empty, then the text should be the placeholder
        let newLength = textView.text.utf16.count + text.utf16.count - range.length
        if newLength > 0 // have text, so don't show the placeholder
        {
            // check if the only text is the placeholder and remove it if needed
            // unless they've hit the delete button with the placeholder displayed
            if textView == textVIew && textView.text == PLACEHOLDER_TEXT
            {
                if text.utf16.count == 0 // they hit the back button
                {
                    return false // ignore it
                }
                applyNonPlaceholderStyle(textView)
                textView.text = ""
            }
            return true
        }
        else  // no text, so show the placeholder
        {
            applyPlaceholderStyle(textView, placeholderText: PLACEHOLDER_TEXT)
            moveCursorToStart(textView)
            return false
        }
    }
    
    func postDidFinish(){
        
        SwiftEventBus.onMainThread(self, name: "EventMade", handler: { (result) -> Void in
            
            //success
            print("event post successful")
            self.performSegueWithIdentifier("Home", sender: self)
            
        })
        SwiftEventBus.onMainThread(self, name: "EventNotMade", handler: { (result) -> Void in
            
            //Failed
            print("event did not post")
        })
        
        SwiftEventBus.onMainThread(self, name: "PartyMade", handler: { (result) -> Void in
            
            //success
            print("party post successful")
            self.performSegueWithIdentifier("Home", sender: self)
            
        })
        
        SwiftEventBus.onMainThread(self, name: "PartyNotMade", handler: { (result) -> Void in
            
            //Failed
            print("party did not post")
        })

    }
    
    @IBAction func postBTn(sender: AnyObject) {
        
        if type == false && textVIew.text != ""{
            
            
            makeEvent.event("", thePost: textVIew.text, theAddress: address, theLive: live,thelikes:likes,theDate: date,theStartTime: timeStart,theEndTime: timeEnd,thePrivacy:privacy,theLat: lat,theLong: long)
            
        }else if type == true && textVIew.text != ""{
            
            
            makeParty.party("", thePost: textVIew.text, theLocation: address, theLive: live,thelikes:likes,theDate: date,theStartTime: timeStart,theEndTime: timeEnd,thePrivacy:privacy)
        }else{
            
            
            print("present alert to users to make a post")
        }
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }*/
    

}
