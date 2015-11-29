//
//  LiveViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 11/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class LiveViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,PlayerDelegate {
    
    var player:Player!
    
    var testImage:String!
    var testVideo:String!
    
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textViewBg: UIView!
    @IBOutlet weak var send: UIButton!
    
    let imageTypes:[String] = ["jpg","jpeg","png","tiff","tif"]
    let videoTypes:[String] = ["mov","mp4", "m4v","3gp"]
    let comments:[String] = ["test comment", "more comments", "3rd test commemnt"]
    
    var fileArray:[String]!
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLayoutSubviews() {
        
        textView.layer.cornerRadius = 2
        textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        textView.layer.borderWidth = 1
        textView.layer.masksToBounds = true

        visualEffectView.frame = self.view.frame
        visualEffectView.clipsToBounds = true
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let image = UIImage(named: "bg")
        applyBlurEffect(image!)*/
        
        //visualEffectView.alpha = 0.8
        
        self.view.insertSubview(visualEffectView, aboveSubview: bg)
        
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
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
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
        blurfilter!.setValue(30, forKey: kCIInputRadiusKey)
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
