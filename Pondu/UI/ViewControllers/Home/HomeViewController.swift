//
//  HomeViewController.swift
//  Pondu
//
//  Created by Jonathan Green on 12/13/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    var storyUser:theUser = theUser()
    
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var favorites: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        
        setupUI()
        
        self.navigationController?.navigationBarHidden = true
        
        /*storyUser.theUsers { (theData) -> Void in
            
            for user in theData {
                
                if user.objectID == PFUser.currentUser()?.objectId {
                    
                    self.userName.text = user.userName
                    self.favorites.text = "\(user.Favorites.count) Favorites"
                    self.location.text = "I Live In \(user.area)"
                    self.image.kf_setImageWithURL(NSURL(string:user.photo)!, placeholderImage: UIImage(named: "placeholder"))
                }
            }
            
        }*/
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupUI(){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            
            self.image.layer.cornerRadius = self.image.layer.frame.height/2
            self.image.layer.masksToBounds = true
        });

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
