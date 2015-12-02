//
//  LiveViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class LiveViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,PlayerDelegate {
    
    var player:Player!
    
    var testImage:String!
    var testVideo:String!
    let PLACEHOLDER_TEXT = "Leave a comment..."
    
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
   
    @IBOutlet weak var textViewBg: UIView!
    @IBOutlet weak var send: UIButton!
    
    let imageTypes:[String] = ["jpg","jpeg","png","tiff","tif"]
    let videoTypes:[String] = ["mov","mp4", "m4v","3gp"]
    let comments:[String] = ["asdasdasdsadasdasdasdsadasdasdasdasdasdasdasdasdsadasasdasdasdsadasdasdasdasdasdasdasdasdsadasasdasdasdsadasdasdasdasdasdasdasdasdsadasasdasdasdsadasdasdasdasdasdasdasdasdsadasasdasdasdasdasdasdasdasdsadas comment", "more comments", "3rd test commemnt"]
    
    var fileArray:[String]!
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var middleView: UIView!
    
    override func viewDidLayoutSubviews() {
        
       
        //middleView.layer.cornerRadius = 2
        middleView.layer.borderColor = UIColor.blackColor().CGColor
        middleView.layer.borderWidth = 0.5
        middleView.layer.masksToBounds = true
        
        textView.layer.cornerRadius = 2
        textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        textView.layer.borderWidth = 1
        textView.textColor = UIColor.whiteColor()
        textView.layer.masksToBounds = true
        
        textView.delegate = self
        
        //visualEffectView.frame = self.view.frame
        //visualEffectView.clipsToBounds = true
        
         applyPlaceholderStyle(textView!, placeholderText: PLACEHOLDER_TEXT)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // tableview.estimatedRowHeight = 75
        //tableview.rowHeight = UITableViewAutomaticDimension
        
        //self.tableview.estimatedRowHeight = 75
        //self.tableview.rowHeight = UITableViewAutomaticDimension
        
        /*let image = UIImage(named: "girl")
        applyBlurEffect(image!)*/
        
        //visualEffectView.alpha = 0.8
        
        //self.view.insertSubview(visualEffectView, aboveSubview: bg)
        
        tableview.separatorStyle = .None
        
        fileArray = [testImage,testVideo]
        
        print(testImage)
        
        collectionView.reloadData()

    }
    
    ///Mark CollectionView datasource protocols
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return fileArray.count
    }
    

   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:LiveCell = collectionView.dequeueReusableCellWithReuseIdentifier("LiveCell", forIndexPath: indexPath) as! LiveCell
        
        //cell.contentView.backgroundColor = UIColor.blueColor()
        
        /*var imageViewObject:UIImageView!
        imageViewObject = UIImageView(frame:cell.contentView.frame);
        imageViewObject.kf_setImageWithURL(NSURL(string:testImage)!, placeholderImage: UIImage(named: "placeholder"))
        cell.contentView.addSubview(imageViewObject)*/
        
       

        return cell
    }
    
    
   
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        
         getFileType(fileArray[indexPath.item],cell: cell as! LiveCell)
        
    }
    
     ///Mark TableView datasource protocols
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:LiveCommentCell = tableView.dequeueReusableCellWithIdentifier("Comment", forIndexPath: indexPath) as! LiveCommentCell
        
            cell.comment.text = comments[indexPath.row]
        
            cell.avatar.image = UIImage(named: "bob")
        
        
        
        if comments[indexPath.row].characters.count > 26 {
            
            tableview.estimatedRowHeight = 75
            tableview.rowHeight = UITableViewAutomaticDimension
        }else {
            
            tableview.rowHeight = 75
        }
        
        
       
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }
    
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    //mark textview delegates
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        textView.resignFirstResponder()
    }
    
    func applyPlaceholderStyle(aTextview: UITextView, placeholderText: String) {
        // make it look (initially) like a placeholder
        aTextview.textColor = UIColor.lightGrayColor()
        aTextview.text = placeholderText
    }
    
    func applyNonPlaceholderStyle(aTextview: UITextView) {
        // make it look like normal text instead of a placeholder
        aTextview.textColor = UIColor.lightTextColor()
        aTextview.alpha = 1.0
    }
    
    func textViewShouldBeginEditing(aTextView: UITextView) -> Bool {
        if aTextView == textView && aTextView.text == PLACEHOLDER_TEXT {
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
            if textView == textView && textView.text == PLACEHOLDER_TEXT
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func isImage(image:String,cell:LiveCell){
        
        print("got image \(image)")
        
        var imageViewObject:UIImageView!
        imageViewObject = UIImageView(frame:cell.contentView.frame);
        imageViewObject.kf_setImageWithURL(NSURL(string:image)!, placeholderImage: UIImage(named: "placeholder"))
        imageViewObject.contentMode = .ScaleAspectFill
        cell.contentView.addSubview(imageViewObject)
    }
    
    
    func isVideo(video:String,cell:LiveCell){
        
        player = Player()
        player.delegate = self
        player.view.frame = cell.contentView.bounds
        
        self.addChildViewController(self.player)
        cell.contentView.addSubview(self.player.view)
        self.player.didMoveToParentViewController(self)
        
        self.player.setUrl(NSURL(string: video)!)
        
        self.player.playbackLoops = true
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTapGestureRecognizer:")
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
    
        //self.player.playFromBeginning()
        
    }
    
    func getFileType(thefile:String,cell:LiveCell){
        
        var indexOfUrl:[Character] = []
        
        for i in thefile.characters {
            //print(i)
            
            indexOfUrl.append(i)
        }
        
        let letterIndex = indexOfUrl.count - 1
        
        let chac1 = indexOfUrl[letterIndex]
        let chac2 = indexOfUrl[letterIndex - 1]
        let chac3 = indexOfUrl[letterIndex - 2]
        
        let fileType = "\(chac3)\(chac2)\(chac1)"
        
        if (fileType == videoTypes[0]) || (fileType == videoTypes[1]) || (fileType == videoTypes[2]) || (fileType == videoTypes[3]) {
            
            isVideo(thefile,cell:cell)
            //print(fileType)
            print(thefile)
        }else{
            
            isImage(thefile,cell: cell)
            //print(fileType)
            print(thefile)

        }
        
       
    }
    
    // MARK: UIGestureRecognizer
    
    func handleTapGestureRecognizer(gestureRecognizer: UITapGestureRecognizer) {
        switch (self.player.playbackState.rawValue) {
        case PlaybackState.Stopped.rawValue:
            self.player.playFromBeginning()
        case PlaybackState.Paused.rawValue:
            self.player.playFromCurrentTime()
        case PlaybackState.Playing.rawValue:
            self.player.pause()
        case PlaybackState.Failed.rawValue:
            self.player.pause()
        default:
            self.player.pause()
        }
    }
    
    // MARK: PlayerDelegate
    
    func playerReady(player: Player) {
    }
    
    func playerPlaybackStateDidChange(player: Player) {
    }
    
    func playerBufferingStateDidChange(player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(player: Player) {
    }
    
    func playerPlaybackDidEnd(player: Player) {
    }
    
    func applyBlurEffect(image: UIImage){
        let imageToBlur = CIImage(image: image)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(5, forKey: kCIInputRadiusKey)
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        let resultImage = blurfilter!.valueForKey("outputImage") as! CIImage
        var blurredImage = UIImage(CIImage: resultImage)
        let cropped:CIImage=resultImage.imageByCroppingToRect(CGRectMake(0, 0,imageToBlur!.extent.size.width, imageToBlur!.extent.size.height))
        blurredImage = UIImage(CIImage: cropped)
        self.bg.image = blurredImage
        
        
    }
    
    
    @IBAction func sendBtn(sender: AnyObject) {
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
