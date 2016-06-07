//
//  AppDelegate.m
//  qwe
//
//  Created by 黄维荣 on 16/3/16.
//  Copyright © 2016年 黄维荣. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import "ViewController.h"
#import "RootNavigationController.h"
#import "LockViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //界面判断
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"first"];
    //第一次运行界面
    if (isFirst == NO) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first"];
        //手势状态 只加载一次
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"lockState"];
        //设置密码锁状态
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isOpen"];
    }
    //不是第一次运行
    else {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        RootNavigationController *rootNav = [story instantiateViewControllerWithIdentifier:@"rootNav"];
//        self.window.rootViewController = rootNav;
        LockViewController *rootVc = [story instantiateViewControllerWithIdentifier:@"lockView"];
        self.window.rootViewController = rootVc;
        

    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
