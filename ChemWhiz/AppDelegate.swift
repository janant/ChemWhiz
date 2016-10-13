//
//  AppDelegate.swift
//  ChemWhiz
//
//  Created by Anant Jain on 11/13/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        window?.tintColor = UIColor(red: 102/255.0, green: 192/255.0, blue: 185/255.0, alpha: 1.0)
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        guard let tabBarController = self.window?.rootViewController as? UITabBarController else {
            completionHandler(false)
            return
        }
        if shortcutItem.type == "edu.self.ChemWhiz.calculate-molar-mass" {
            tabBarController.selectedIndex = 0
            completionHandler(true)
        }
        else if shortcutItem.type == "edu.self.ChemWhiz.conversions" {
            tabBarController.selectedIndex = 1
            completionHandler(true)
        }
        else if shortcutItem.type == "edu.self.ChemWhiz.elements" {
            tabBarController.selectedIndex = 2
            completionHandler(true)
        }
        else {
            completionHandler(false)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

