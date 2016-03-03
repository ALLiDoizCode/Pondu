//
//  School.swift
//  Pondu
//
//  Created by Jonathan Green on 12/12/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import Foundation

class School {
    
    var name:String!
    var city:String!
    var zipcode:String!
    var address:String!
    var county:String!
    var long:String!
    var lat:String!
    
    init(theName:String,theCity:String,theZip:String,theAddress:String,theCounty:String,theLong:String,theLat:String){
        
        name = theName
        city = theCity
        zipcode = theZip
        address = theAddress
        county = theCounty
        long = theLong
        lat = theLat
    }
}
