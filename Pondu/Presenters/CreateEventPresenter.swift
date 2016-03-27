//
//  CreateEventPresenter.swift
//  Pondu
//
//  Created by Jonathan Green on 11/3/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus
import Kingfisher

class MakingEvent {
    
    let client = WallClient()
    
    func event(theTitle:String,theDescription:String,TheProfilePicture:UIImage,theAddress:String,theLive:Bool,thelikes:Int,theDate:NSDate,theStartTime:NSDate,theEndTime:NSDate,thePrivacy:Bool,theLat:Double,theLong:Double,isEvent:Bool,CompletionHandler:(success:Bool) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "makeWall") { (notification) -> Void in
            
            let success = notification.object as! Bool
            
            CompletionHandler(success: success)
        }
        
        client.post(theTitle, theDescription: theDescription, TheProfilePicture: TheProfilePicture, theAddress: theAddress, theLive: theLive, thelikes: thelikes, theDate: theDate, theStartTime: theStartTime, theEndTime: theEndTime, thePrivacy: thePrivacy, theLat: theLat, theLong: theLong,isEvent:isEvent)
    }
    
}

