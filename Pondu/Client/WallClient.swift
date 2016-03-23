//
//  WallClient.swift
//  Pondu
//
//  Created by Jonathan Green on 3/22/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit

class WallClient {
    
    let date = NSDate(timeIntervalSince1970: 1352149171)
    let store = KCSAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName : "Wall",
        KCSStoreKeyCollectionTemplateClass : Wall.self
        ])

    
    func post(){
        
        let wall = Wall(theTitle: "test", theDescription: "test", TheProfilePicture: "test", theAddress: "test", theLive: true, thelikes: 1, theDate:date , theStartTime: date, theEndTime: date, thePrivacy: true, theLat: 11.02, theLong: 52.10)
        store.saveObject(
            wall,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil != nil {
                    //save failed
                    NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
                } else {
                    //save was successful
                    NSLog("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                }
            },
            withProgressBlock: nil
        )
    }
}