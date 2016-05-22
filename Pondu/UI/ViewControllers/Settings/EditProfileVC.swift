//
//  EditProfileVC.swift
//  Pondu
//
//  Created by Jonathan Green on 5/22/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material
import Cartography

class EditProfileVC: UIViewController {
    
    var topView:UIView!
    var bottomView:UIView!
    var profileImage:UIImageView!
    
    var cancle:UIButton!
    var save:UIButton!
    var changeProfileImage:UIButton!
    
    var currentTitle:UILabel!
    
    var firstName:TextField!
    var lastName:TextField!
    var username:TextField!
    var email:TextField!
    var phoneNumber:TextField!
    var password:TextField!
    var password2:TextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeViews()
        makeTextFields()
        makeBtns()
        makeLbls()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeViews() {
        topView = UIView()
        bottomView = UIView()
        //topView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.layer.bounds.width, height: self.view.layer.bounds.height * 0.3))
        topView.backgroundColor = MaterialColor.blue.accent1
        self.view.addSubview(topView)
        
        //bottomView = UIView(frame: CGRect(x: 0, y: 100, width: self.view.layer.bounds.width, height: self.view.layer.bounds.height * 0.6))
        bottomView.backgroundColor = MaterialColor.red.accent1
        self.view.addSubview(bottomView)
        
        constrain(topView,bottomView){ topView, bottomView in
            
            topView.top == topView.superview!.top
            topView.width == topView.superview!.width
            topView.height == (topView.superview?.height)! * (1/3)
            
            bottomView.bottom == bottomView.superview!.bottom
            bottomView.width == bottomView.superview!.width
            bottomView.height == (bottomView.superview?.height)! * (2/3)
        }
        
        
    }
    
    func makeTextFields(){
        
    }
    
    
    func makeBtns(){
        
    }
    
    func makeLbls(){
        
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
