//
//  NHAppDelegate.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-13.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#import "NHAppDelegate.h"
#import "NavigationViewController.h"

@implementation NHAppDelegate
@synthesize gotoInitView;
@synthesize gotoInitViewTmp;
@synthesize torchIsON;
@synthesize torchBrightness;

-(NSDictionary *)initialDefaults:(NSString *)key{
    if ([key isEqualToString:kGotoInitView]){
        NSNumber *tmp=[[NSNumber alloc]initWithInteger:0];
        return [[NSDictionary alloc]initWithObjectsAndKeys:tmp,kGotoInitView, nil];
    }else if ([key isEqualToString:kTorchIsON]){
        NSNumber *tmp=[[NSNumber alloc]initWithBool:YES];
        return [[NSDictionary alloc]initWithObjectsAndKeys:tmp,kTorchIsON, nil];
    }else if ([key isEqualToString:kTorchBrightness]){
        NSNumber *tmp=[[NSNumber alloc]initWithDouble:1.0];
        return [[NSDictionary alloc]initWithObjectsAndKeys:tmp,kTorchBrightness, nil];
    }else
        return nil;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults registerDefaults:[self initialDefaults:kGotoInitView]];
    gotoInitView = [userDefaults integerForKey:kGotoInitView];
    gotoInitViewTmp = gotoInitView;
    [userDefaults registerDefaults:[self initialDefaults:kTorchIsON]];
    torchIsON = [userDefaults boolForKey:kTorchIsON];
    [userDefaults registerDefaults:[self initialDefaults:kTorchBrightness]];
    torchBrightness = [userDefaults floatForKey:kTorchBrightness];
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
