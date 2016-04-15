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
    
    
     let user = KCSUser.activeUser()
    //let date = NSDate(timeIntervalSince1970: 1352149171)
    //let image = UIImage(named: "girl")
    let store = KCSLinkedAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName : "Wall",
        KCSStoreKeyCollectionTemplateClass : Wall.self
        ])
    
    var currentWall:[Wall] = []

    
    func post(theTitle:String,theDescription:String,theAddress:String,theLive:Bool,thelikes:Int,theDate:NSDate,theStartTime:NSDate,theEndTime:NSDate,thePrivacy:Bool,isEvent:Bool,theGeo:CLLocation){
        
        let profileImage = user.getValueForAttribute("ProfileImage") as! String
        
        print("user image \(profileImage)")
        
        let wall = Wall(theTitle: theTitle, theDescription: theDescription,theAddress: theAddress, theLive: theLive, thelikes: thelikes, theDate:theDate, theStartTime: theStartTime, theEndTime: theEndTime, thePrivacy: thePrivacy,isEvent:isEvent,theGeo:theGeo,theCreatedBy:user.username,theCreatorImage:profileImage)
        
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
    
    func getPost(){
        
        currentWall = []
        
        let collection = KCSCollection(fromString: "Wall", ofClass: NSDictionary.self)
        let wallStore = KCSCachedStore(collection: collection, options: nil)
        
        wallStore.queryWithQuery(
            KCSQuery(),
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                
                if errorOrNil != nil {
                    
                    print("no objects")
                    
                }else{
                    
                    print("we got \(objectsOrNil.count) objects")
                    
                    for  object:NSDictionary in objectsOrNil as! [NSDictionary] {
                        
                        //print("the object \(object.allKeys)")
                        //print("the object values \(object!.allValues)")
                        
                        
                        let title = object.valueForKey("title") as? String
                        let address = object.valueForKey("address") as? String
                        let live = object.valueForKey("live") as? Bool
                        let likes = object.valueForKey("likes") as? Int
                        let date = object.valueForKey("date") as! String
                        let startTime = object.valueForKey("startTime") as! String
                        let endTime = object.valueForKey("endTime") as! String
                        let privacy = object.valueForKey("privacy") as? Bool
                        let creator = object.valueForKey("createdBy") as? String
                        let geo = object.valueForKey("_geoloc") as? [Double]
                        let image = object.valueForKey("creatorImage") as? String
                        let event = object.valueForKey("event") as? Bool
                        let long = geo![0]
                        let lat = geo![1]
                        
                        let location = CLLocation(latitude: lat, longitude: long)
                        
                        let theDate = NSDate.dateFromISOString(date)
                        let theStart = NSDate.dateFromISOString(startTime)
                        let theEnd = NSDate.dateFromISOString(endTime)
                        
                        let myEvent = Wall(theTitle: title!, theDescription: "", theAddress: address!, theLive: live!, thelikes: likes!, theDate: theDate, theStartTime: theStart, theEndTime: theEnd, thePrivacy: privacy!, isEvent: event!, theGeo: location, theCreatedBy: creator!,theCreatorImage:image!)
                        
                        self.currentWall.append(myEvent)
                        
                    }
                    
                    SwiftEventBus.post("MainWallEvent", sender: self.currentWall)
                }
                
            },
            withProgressBlock: nil
            
            
        )
    }
    
    func getFile(fileId:String,completion:(data:NSURL) -> Void){
        
        print("will get file")
        
        KCSFileStore.downloadFile(
            fileId,
            options: nil,
            completionBlock: { (downloadedResources: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    
                    print("got file")
                    let file = downloadedResources[0] as! KCSFile
                    //let fileURL = file.localURL
                    //let image = UIImage(contentsOfFile: fileURL.path!) //note this blocks for awhile
                    print("the url of the image \(file.remoteURL)")
                    
                    completion(data: file.remoteURL!)
                    
                } else {
                    NSLog("Got an error: %@", error)
                }
            },
            progressBlock: nil
        )
    }
}