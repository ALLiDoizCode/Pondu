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
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var next: UIButton!
    var type:Bool!
    var wallType:Bool!
    var eventBegins:NSDate!
    var privacy:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPickerToolBar()
        createStartPickerToolBar()

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
    
    func startDonePressed(sender: UIBarButtonItem) {
        
        startTime.resignFirstResponder()
        
    }

    
    func endDonePressed(sender: UIBarButtonItem) {
        
        endTime.resignFirstResponder()
        
    }

    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateformatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        date.text = dateformatter.stringFromDate(NSDate())
        
        date.resignFirstResponder()
    }
    
    func startTappedToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = NSDateFormatter()
        
        //dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateformatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let now = dateformatter.stringFromDate(NSDate())
    
        startTime.text = now
        
        eventBegins = NSDate()
        
        startTime.resignFirstResponder()
    }
    
    func endTappedToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = NSDateFormatter()
        
        //dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateformatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        endTime.text = dateformatter.stringFromDate(NSDate())
        
        endTime.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

   
    
    /////////////////////Date////////////////////////////////
    @IBAction func dateAction(sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        setupDatePicker(datePickerView)
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func setupDatePicker(datePickerView:UIDatePicker){
        
        let currentDate: NSDate = NSDate()
        
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        // let calendar: NSCalendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone(name: "UTC")!
        
        let components: NSDateComponents = NSDateComponents()
        components.calendar = calendar
        
        let minDate: NSDate = calendar.dateByAddingComponents(components, toDate: currentDate, options: NSCalendarOptions(rawValue: 0))!
        
        datePickerView.minimumDate = minDate
    }
    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        date.text = dateFormatter.stringFromDate(sender.date)
        
    }
     /////////////////////DateEnd////////////////////////////////
    
    /////////////////////Time////////////////////////////////
    @IBAction func Start(sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Time
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("startTimePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        setupDatePicker(datePickerView)
    }
    
    @IBAction func End(sender: UITextField) {
        
        if startTime.text == "" {
            
            print("You need to set a Start time first")
            
        }else {
            
            createEndPickerToolBar()
            
            let datePickerView:UIDatePicker = UIDatePicker()
            
            datePickerView.datePickerMode = UIDatePickerMode.Time
            
            sender.inputView = datePickerView
            
            datePickerView.addTarget(self, action: Selector("endTimePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
            
            datePickerView.minimumDate = eventBegins.add(years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: 30, seconds: 0)
        }
        
    }
    
    
    func startTimePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        //dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        startTime.text = dateFormatter.stringFromDate(sender.date)
        
        eventBegins = sender.date
        
    }
    
    func endTimePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        //dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        endTime.text = dateFormatter.stringFromDate(sender.date)
        
    }
    /////////////////////TimeEnd////////////////////////////////
    
    func createPickerToolBar(){
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.Default
        
        toolBar.tintColor = UIColor.blackColor()
        
        toolBar.backgroundColor = UIColor.lightGrayColor()
        
        
        let todayBtn = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.Plain, target: self, action: "tappedToolBarBtn:")
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "donePressed:")
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clearColor()
        
        label.textColor = UIColor.blackColor()
        
        label.text = "Select a date"
        
        label.textAlignment = NSTextAlignment.Center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        date.inputAccessoryView = toolBar
        
    }
    
    func createStartPickerToolBar(){
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.Default
        
        toolBar.tintColor = UIColor.blackColor()
        
        toolBar.backgroundColor = UIColor.lightGrayColor()
        
        
        let todayBtn = UIBarButtonItem(title: "Now", style: UIBarButtonItemStyle.Plain, target: self, action: "startTappedToolBarBtn:")
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "startDonePressed:")
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clearColor()
        
        label.textColor = UIColor.blackColor()
        
        label.text = "Select a Time"
        
        label.textAlignment = NSTextAlignment.Center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        startTime.inputAccessoryView = toolBar
  
    }
    
    func createEndPickerToolBar(){
            
            let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
            
            toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
            
            toolBar.barStyle = UIBarStyle.Default
            
            toolBar.tintColor = UIColor.blackColor()
            
            toolBar.backgroundColor = UIColor.lightGrayColor()
            
            //let todayBtn = UIBarButtonItem(title: "Now", style: UIBarButtonItemStyle.Plain, target: self, action: "endTappedToolBarBtn:")
            
            let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "endDonePressed:")
            
            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
            
            label.font = UIFont(name: "Helvetica", size: 12)
            
            label.backgroundColor = UIColor.clearColor()
            
            label.textColor = UIColor.blackColor()
            
            label.text = "Select a Time"
            
            label.textAlignment = NSTextAlignment.Center
            
            let textBtn = UIBarButtonItem(customView: label)
            
            toolBar.setItems([flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
            
            endTime.inputAccessoryView = toolBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextBtn(sender: AnyObject) {
        
        if date.text != "" && endTime.text != "" && startTime.text != "" {
            
            self.performSegueWithIdentifier("Location", sender: self)
            
        }else{
            
            print("post alert for no selection")
        }
    }
 
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Location" {
            
            let nextViewController:LocationViewController = segue.destinationViewController as! LocationViewController
            
            nextViewController.type = type
            nextViewController.wallType = wallType
            nextViewController.timeStart = startTime.text
            nextViewController.timeEnd = endTime.text
            nextViewController.date = date.text
            nextViewController.privacy = privacy
            
            print("passing \(type)")
            print("passing \(wallType)")
            print("passing \(date.text)")
            print("passing \(endTime.text)")
            print("passing \(startTime.text)")
            print("passing \(privacy)")
            
        }
    }
    

}
