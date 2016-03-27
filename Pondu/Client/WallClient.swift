//
//  WallClient.swift
//  Pondu
//
//  Created by Jonathan Green on 3/22/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit
import SwiftEventBus

class WallClient {
    
    //let date = NSDate(timeIntervalSince1970: 1352149171)
    //let image = UIImage(named: "girl")
    let store = KCSLinkedAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName : "Wall",
        KCSStoreKeyCollectionTemplateClass : Wall.self
        ])

    
    func post(theTitle:String,theDescription:String,theAddress:String,theLive:Bool,thelikes:Int,theDate:NSDate,theStartTime:NSDate,theEndTime:NSDate,thePrivacy:Bool,isEvent:Bool,theGeo:CLLocation){
        
        let wall = Wall(theTitle: theTitle, theDescription: theDescription,theAddress: theAddress, theLive: theLive, thelikes: thelikes, theDate:theDate, theStartTime: theStartTime, theEndTime: theEndTime, thePrivacy: thePrivacy,isEvent:isEvent,theGeo:theGeo)
        self.store.saveObject(
            wall,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil != nil {
                    //save failed
                    NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
                } else {
                    //save was successful
                    NSLog("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                    
                    SwiftEventBus.post("makeWall", sender: true)
                }
            },
            withProgressBlock: nil
        )
    }
    
    func getPost(completion:(imageData:UIImage) -> Void){
        
        let collection = KCSCollection(fromString: "Wall", ofClass: NSDictionary.self)
        let wallStore = KCSCachedStore(collection: collection, options: [ KCSStoreKeyCachePolicy : KCSCachePolicy.LocalFirst.rawValue ])
        
        wallStore.queryWithQuery(
            KCSQuery(),
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                
                if errorOrNil != nil || objectsOrNil.count == 0 {
                    
                    print("the error \(errorOrNil)")
                    
                }else{
                    
                    print("we got \(objectsOrNil.count) objects")
                    
                    for  object:NSDictionary in objectsOrNil as! [NSDictionary] {
                        
                        let title = object.valueForKey("title") as? String
                        let image = object.valueForKey("profilePicture") as? String
                        
                        print("the title is \(title)")
                        print("the image is \(image)")
                        
                        self.getFile(image!, completion: { (data) -> Void in
                            
                            completion(imageData: data)
                        })
                    }
                }
                
            },
            withProgressBlock: nil
        )
    }
    
    func getFile(fileId:String,completion:(data:UIImage) -> Void){
        
        KCSFileStore.downloadFile(
            fileId,
            options: nil,
            completionBlock: { (downloadedResources: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    let file = downloadedResources[0] as! KCSFile
                    let fileURL = file.localURL
                    let image = UIImage(contentsOfFile: fileURL.path!) //note this blocks for awhile
                    print("the url of the image \(image)")
                    
                    completion(data: image!)
                    
                } else {
                    NSLog("Got an error: %@", error)
                }
            },
            progressBlock: nil
        )
    }
}