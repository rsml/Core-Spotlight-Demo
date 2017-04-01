//
//  AppDelegate.m
//  Core Spotlight Continuation Demo
//
//  Created by 于宙 on 2017/4/1.
//  Copyright © 2017年 ryan. All rights reserved.
//

#import "AppDelegate.h"
@import CoreSpotlight;
@import MobileCoreServices;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

#pragma mark - Spotlight
//whether to handel click in the Spotlight
- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
    if ([userActivityType isEqualToString:CSSearchableItemActionType]) {
        //user clicked item in the Spotlight search results list
        return YES;
    }
    
    if ([userActivityType isEqualToString:CSQueryContinuationActionType]) {
        //user clicked "Search in App" Button at top right of Spotlight search results list
        return YES;
    }
    
    return NO;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
    if ([userActivity.activityType isEqualToString:CSSearchableItemActionType]) {
        NSString *itemIdentifier = userActivity.userInfo[CSSearchableItemActivityIdentifier];
        NSLog(@"item's identifier: %@", itemIdentifier);
        //TODO: you should show contents of item user clicked in Spotlight
        return YES;
    }
    
    if ([userActivity.activityType isEqualToString:CSQueryContinuationActionType]) {
        NSString *queryString = userActivity.userInfo[CSSearchQueryString];
        NSLog(@"query string: %@", queryString);
        //TODO: you should search In-app contents with query string user typed in the Spotlight textfield, then show search results
        return YES;
    }
    
    return NO;
}

@end
