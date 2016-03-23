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
    let image = UIImage(named: "girl")
    let store = KCSLinkedAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName : "Wall",
        KCSStoreKeyCollectionTemplateClass : Wall.self
        ])

    
    func post(){
        
        let data = UIImageJPEGRepresentation(image!, 0.9)
        
        KCSFileStore.uploadData(
            data,
            options: nil,
            completionBlock: { (uploadInfo: KCSFile!, error: NSError!) -> Void in
                //NSLog("Upload finished. File id='%@', error='%@'.", uploadInfo.fileId, error)
                
                let wall = Wall(theTitle: "test", theDescription: "test", TheProfilePicture: uploadInfo.fileId, theAddress: "test", theLive: true, thelikes: 1, theDate:self.date , theStartTime: self.date, theEndTime: self.date, thePrivacy: true, theLat: 11.02, theLong: 52.10)
                self.store.saveObject(
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
            },
            progressBlock: nil
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