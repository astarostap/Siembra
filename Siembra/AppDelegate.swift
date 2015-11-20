 //
//  AppDelegate.swift
//  Siembra
//
//  Created by Abraham Starosta on 11/15/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import Parse
import Bolts
import FBSDKCoreKit
import ParseFacebookUtilsV4
import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("zpB1Ay8VCo6vL85v7YdiciBwNqbnFxwyw7WHBlrN",
            clientKey: "LPiN9ySGm18lNaW2RBNyOo7on3HQFaj6qJU6sIcF")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        //Tab bar appearance
        let appearance = UITabBar.appearance()
        appearance.tintColor = UIColor(netHex:0xD5AFFF)
        appearance.barTintColor = UIColor.blackColor()
        
        let tabBarController :UITabBarController  = self.window?.rootViewController! as! UITabBarController
        
        let tabBar :UITabBar = tabBarController.tabBar
        let tabBarItem1 :UITabBarItem = (tabBar.items![0]) //search
        let tabBarItem2 :UITabBarItem = (tabBar.items![1]) //home
        let tabBarItem3 :UITabBarItem = (tabBar.items![2]) //you
        
        let searchImage: UIImage = UIImage(named: "rsz_2search.png")!
        tabBarItem3.image = searchImage
        
        let homeImage: UIImage = UIImage(named: "rsz_home.png")!
        //tabBarItem2.image = homeImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabBarItem1.image = homeImage
        
        let heartImage: UIImage = UIImage(named: "rsz_heart.png")!
        tabBarItem2.image = heartImage
        
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            print("user is NOT logged in")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController :UIViewController  = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
            self.window?.rootViewController?.presentViewController(loginViewController, animated: false, completion: nil)
        } else {
            print("user IS logged in")
        }
    
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
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
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("going active again!!!!!!!!!")
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
