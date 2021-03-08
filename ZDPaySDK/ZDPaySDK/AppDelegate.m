//
//  AppDelegate.m
//  ZDPaySDK
//
//  Created by FANS on 2020/4/20.
//  Copyright © 2020 ZhongDaoGroup. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AlipayTool.h"
#import "ZDPay_OrderSureViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
//    UIViewController *vc = [UIViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *vc = [ViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {

    return [[ZDPay_OrderSureViewController manager] handleOpenURL:url];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return [[ZDPay_OrderSureViewController manager] handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    
    if([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        
        NSURL *webpageURL = userActivity.webpageURL;
        [[ZDPay_OrderSureViewController manager] handleOpenURL:webpageURL];
    }
    return YES;
    
}

@end
