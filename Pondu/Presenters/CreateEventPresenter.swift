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
import SwiftLocation
import CoreLocation

class MakingEvent {
    
    let client = WallClient()
    
    func event(theTitle:String,theDescription:String,theAddress:String,theLive:Bool,thelikes:Int,theDate:NSDate,theStartTime:NSDate,theEndTime:NSDate,thePrivacy:Bool,isEvent:Bool,currentGeo:Bool,theGeo:CLLocation,CompletionHandler:(success:Bool) -> Void){
        
        SwiftEventBus.onMainThread(self, name: "makeWall") { (notification) -> Void in
            
            let success = notification.object as! Bool
            
            CompletionHandler(success: success)
        }
        
        if currentGeo {
            
            self.client.post(theTitle, theDescription: theDescription,theAddress: theAddress, theLive: theLive, thelikes: thelikes, theDate: theDate, theStartTime: theStartTime, theEndTime: theEndTime, thePrivacy: thePrivacy,isEvent:isEvent,theGeo:theGeo)
            
        }else {
            
            SwiftLocation.shared.reverseAddress(Service.Apple, address: theAddress, region: nil, onSuccess: { (place) -> Void in
                // our CLPlacemark is here
                
                 self.client.post(theTitle, theDescription: theDescription,theAddress: theAddress, theLive: theLive, thelikes: thelikes, theDate: theDate, theStartTime: theStartTime, theEndTime: theEndTime, thePrivacy: thePrivacy,isEvent:isEvent,theGeo:(place?.location)!)
                
                }) { (error) -> Void in
                    // something went wrong
            }
        }
        
    }
    
}

