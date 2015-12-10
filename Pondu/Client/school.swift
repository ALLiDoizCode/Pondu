//
//  school.swift
//  Pondu
//
//  Created by Jonathan Green on 12/10/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import Foundation
import Alamofire
import SwiftEventBus

class college {
    
    var listSchool:[String] = []
    
    func getData(name:String){
        
            listSchool = []
            
            let search = "https://inventory.data.gov/api/action/datastore_search?resource_id=38625c3d-5388-4c16-a30f-d105432553a4&q=\(name)"
            
            let limit = "https://inventory.data.gov/api/action/datastore_search?resource_id=38625c3d-5388-4c16-a30f-d105432553a4&limit=100000"
            
            Alamofire.request(.GET,search )
                .response { request, response, data, error in
                    //print(request)
                    //print(response)
                    //print(data)
                    //print(error)
                    
                    let json = JSON(data: data!)
                    
                    let schoolList = json["result"]["records"]
                    
                    for var i = 0; i < schoolList.count; i++ {
                        
                        print("jsonData:\(schoolList[i]["INSTNM"])")
                        
                        let names = schoolList[i]["INSTNM"].stringValue
                        
                        self.listSchool.append(names)

                    }
                    
                    SwiftEventBus.postToMainThread("school", sender: self.listSchool)
        
            }
        
    }
}