//
//  AppDelegate.m
//  ChemWhiz
//
//  Created by Anant Jain on 3/8/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import "AppDelegate.h"
#import "ElementInfoViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[[[(UITabBarController *)self.window.rootViewController tabBar] items] objectAtIndex:0] setSelectedImage:[UIImage imageNamed:@"MassTab-Selected.png"]];
    [[[[(UITabBarController *)self.window.rootViewController tabBar] items] objectAtIndex:1] setSelectedImage:[UIImage imageNamed:@"ConversionsTab-Selected.png"]];
    [[[[(UITabBarController *)self.window.rootViewController tabBar] items] objectAtIndex:2] setSelectedImage:[UIImage imageNamed:@"ElementsTab-Selected.png"]];
    
    UISplitViewController *elementsSplitViewController = (UISplitViewController *)[(UITabBarController *)self.window.rootViewController viewControllers][2];
    elementsSplitViewController.delegate = self;
    
    return YES;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    ElementInfoViewController *elementInfoVC = (ElementInfoViewController *)[(UINavigationController *)secondaryViewController topViewController];
    if (elementInfoVC.elementSymbol) {
        return NO;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Deselect URL cell" object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
