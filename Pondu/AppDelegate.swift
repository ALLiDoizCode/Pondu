//
//  AppDelegate.swift
//  Pondu
//
//  Created by Jonathan Green on 10/25/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftEventBus

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let APP_ID = "kid_-15_5uSkxW"
    let APP_SECERT = "b6db7e0dd4c74c8e9ba50f0f296a8fee"


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        KCSClient.sharedClient().initializeKinveyServiceForAppKey(
            APP_ID,
            withAppSecret: APP_SECERT,
            usingOptions: nil
        )
        
        KCSPush.registerForPush()
        
        
        KCSPing.pingKinveyWithBlock { (result: KCSPingResult!) -> Void in
            if result.pingWasSuccessful {
                NSLog("Kinvey Ping Success")
            } else {
                NSLog("Kinvey Ping Failed")
            }
        }
        
        let userNotificationTypes: UIUserNotificationType = [.Alert, .Badge, .Sound]
        
        let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        //enables IQKeyboardManager
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        KCSPush.sharedPush().application(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken,
            completionBlock: { (success: Bool, error: NSError!) -> Void in
                //if there is an error, try again later
            }
        )
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        KCSPush.sharedPush().application(application, didReceiveRemoteNotification: userInfo)
        
        SwiftEventBus.post("NewMessage", sender: userInfo)
        print("got push")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        KCSPush.sharedPush().application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        KCSPush.sharedPush().resetPushBadge()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        KCSPush.sharedPush().registerForRemoteNotifications()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        
         KCSPush.sharedPush().onUnloadHelper()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

