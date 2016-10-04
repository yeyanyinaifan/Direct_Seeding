//
//  AppDelegate.m
//  游戏直播
//
//  Created by tarena on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabbarController.h"
#import "WelcomeViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    MainTabbarController *tbc = [[MainTabbarController alloc]init];
    
    self.window.rootViewController = tbc;
    
    
    //获取之前保存的版本号
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *currentVersion = [ud objectForKey:@"version"];
    
    
    //获取系统版本号
    NSDictionary *dic = [NSBundle mainBundle].infoDictionary;
    NSString *version = dic[@"CFBundleShortVersionString"];
    
    if (![currentVersion isEqualToString:version]) {
        
        //需要显示欢迎页面
        
        self.welcomeWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        //设置级别 级别数越大 越在上面显示 默认0
        self.welcomeWindow.windowLevel = 1;
        self.welcomeWindow.rootViewController = [WelcomeViewController new];
        
        [self.welcomeWindow makeKeyAndVisible];
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
