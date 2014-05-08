//
//  NUAppDelegate.m
//  NUWebOffice
//
//  Created by JY on 14-4-13.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUAppDelegate.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "Reachability.h"
#import "NUUtility.h"
@interface NUAppDelegate()

@property(nonatomic,strong) Reachability  *reachability;

@end

@implementation NUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    sleep(2);
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:2*1024*1024
                                                            diskCapacity:100*1024*1024
                                                                diskPath:@"nucache"];
    [NSURLCache setSharedURLCache:sharedCache];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    
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

#pragma mark - 网络检测
- (void) reachabilityChanged:(NSNotification *)notice
{
    NetworkStatus remoteHostStatus = [self.reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        [NUUtility showProgressHUDWithText:NSLocalizedString(@"NETWORK_ERROR", nil)
                                    inView:self.window];

    }
    else if (remoteHostStatus == ReachableViaWiFi) {
        NSLog(@"wifi network");
    }
    else if (remoteHostStatus == ReachableViaWWAN) {
        [NUUtility showProgressHUDWithText:NSLocalizedString(@"GPRS_CONNECTED", nil)
                                    inView:self.window];

    }
}
@end
