//
//  DateViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/20/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import LTMorphingLabel

class DateViewController: UIViewController {

    @IBOutlet weak var mainLabel: LTMorphingLabel!
    @IBOutlet weak var mainLabel2: LTMorphingLabel!
    @IBOutlet weak var mainLabel2End: LTMorphingLabel!
    @IBOutlet weak var date: UITextField!
    var type:Bool!
    var wallType:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPickerToolBar()
        
        print("retrieved \(type)")
        print("retrieved \(wallType)")
        
        self.title = "Date"
        
        mainLabel.text = "When is this Event"
        mainLabel.morphingEffect = .Evaporate
        mainLabel.morphingDuration = 0.8
        mainLabel.numberOfLines = 0
        
        mainLabel2.text = "What are time frames for"
        mainLabel2.morphingEffect = .Evaporate
        mainLabel2.morphingDuration = 0.8
        mainLabel2.numberOfLines = 0
        mainLabel2.clipsToBounds = true
        
        mainLabel2End.text = "this Event?"
        mainLabel2End.morphingEffect = .Evaporate
        mainLabel2End.morphingDuration = 0.8
        mainLabel2End.numberOfLines = 0
        mainLabel2End.clipsToBounds = true
    }
    
    func donePressed(sender: UIBarButtonItem) {
        
        date.resignFirstResponder()
        
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateformatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        date.text = dateformatter.stringFromDate(NSDate())
        
        date.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func dateAction(sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        date.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func createPickerToolBar(){
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.BlackTranslucent
        
        toolBar.tintColor = UIColor.whiteColor()
        
        toolBar.backgroundColor = UIColor.blackColor()
        
        
        let todayBtn = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.Plain, target: self, action: "tappedToolBarBtn:")
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "donePressed:")
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clearColor()
        
        label.textColor = UIColor.whiteColor()
        
        label.text = "Select a date"
        
        label.textAlignment = NSTextAlignment.Center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        date.inputAccessoryView = toolBar
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
