//
//  UserSignUp.swift
//  Pondu
//
//  Created by Jonathan Green on 10/26/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Parse
import Kingfisher

class SignUP {
    
    let startSignUp = userSignUp()
    
    func AccounSetup(area:String,fullName:String,userName:String,password:String,Bio:String,email:String,phone:String,photo:UIImage,stories:UIImage){
        
        startSignUp.SignUp(area,fullName,userName,password,Bio,email,phone,photo,stories)
    
    
    }
}
