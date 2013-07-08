//
//  TEAppDelegate.m
//  DemoViewDeck
//
//  Created by Tuấn Nguyễn Anh on 7/3/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import "TEAppDelegate.h"
#import "TELeftViewController.h"
#import "TERightViewController.h"
#import "TERootViewController.h"
#import "TEDisclosureViewController.h"
#import "IIViewDeckController.h"

@implementation TEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    IIViewDeckController* deckController = [self generateControllerStack];
    self.window.rootViewController = deckController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (IIViewDeckController*)generateControllerStack {
    
    //UIViewController *centerController = [[TERootViewController alloc] initWithNibName:@"TERootViewController" bundle:nil];
    UIViewController *centerController = [[TEDisclosureViewController alloc] init];
    UIViewController *rightController = [[TERightViewController alloc] init];
    UIViewController *leftController = [[TELeftViewController alloc] init];
    
    centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    IIViewDeckController* deckController =  [[IIViewDeckController alloc]
                                             initWithCenterViewController:centerController leftViewController:leftController rightViewController:rightController];
    deckController.panningMode = IIViewDeckNavigationBarOrOpenCenterPanning;
    deckController.navigationControllerBehavior = IIViewDeckNavigationControllerContained;
    deckController.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    deckController.sizeMode = IIViewDeckViewSizeMode;
    //[deckController disablePanOverViewsOfClass:NSClassFromString(@"_UITableViewHeaderFooterContentView")];
    return deckController;
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
