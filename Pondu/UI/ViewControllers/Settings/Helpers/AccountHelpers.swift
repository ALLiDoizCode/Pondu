//
//  AccountHelpers.swift
//  Pondu
//
//  Created by Jonathan Green on 5/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import SwiftEventBus

class AccountHelpers {
    
    let client:college = college()
    
    func pickSchool(pickerView:UIPickerView,controller:UIViewController,completion:(result:[School]) -> Void){
        
        pickerView.reloadAllComponents()
        
        var schools:[School] = []
        
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Search",
                                            message: "Entered Shool Name",
                                            preferredStyle: .Alert)
        
        
        alertController!.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "School Name"
        })
        
        let action = UIAlertAction(title: "Search",
                                   style: UIAlertActionStyle.Default,
                                   handler: {[weak self]
                                    (paramAction:UIAlertAction!) in
                                    if let textFields = alertController?.textFields{
                                        let theTextFields = textFields as [UITextField]
                                        let enteredText = theTextFields[0].text
                                        let newString = enteredText!.stringByReplacingOccurrencesOfString(" ", withString: "_")
                                        
                                        SwiftEventBus.onMainThread(self!, name: "school", handler: { (result) in
                                            
                                            let data = result.object as! [School]
                                            
                                            schools = data
                                            
                                            if schools.count > 0 {
                                                
                                                print("the number of schools is \(schools.count)")
                                                
                                                completion(result: schools)
                                                
                                            }
                                        })
                                        
                                        self!.client.getData(newString)
                                        print("Entered Shool Name \(newString)")
                                        
                                        //self!.displayLabel.text = enteredText
                                    }
            })
        
        
        
        alertController?.addAction(action)
        controller.presentViewController(alertController!,
                                   animated: true,completion:{
                                    
                                    
        })
        
    }
}