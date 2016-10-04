//
//  MainTabbarController.m
//  游戏直播
//
//  Created by tarena on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MainTabbarController.h"
#import "MineViewController.h"
#import "MainNavigationViewController.h"
#import "LiveListViewController.h"
#import "HomeViewController.h"
#import "CategoryListViewController.h"
@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController *hvc = [HomeViewController new];
    
    CategoryListViewController *cvc = [CategoryListViewController new];
    LiveListViewController *lvc = [LiveListViewController new];
    MineViewController *mvc = [MineViewController new];
    hvc.tabBarItem.image = [UIImage imageNamed:@"推荐_默认"];
    hvc.tabBarItem.selectedImage = [UIImage imageNamed:@"推荐_焦点"];
    hvc.title = @"推荐";
    
    cvc.title = @"栏目";
    cvc.tabBarItem.image = [UIImage imageNamed:@"栏目_默认"];
    cvc.tabBarItem.selectedImage = [UIImage imageNamed:@"栏目_焦点"];
    lvc.title = @"直播";
    lvc.tabBarItem.image = [UIImage imageNamed:@"发现_默认"];
    lvc.tabBarItem.selectedImage = [UIImage imageNamed:@"发现_焦点"];
    
    mvc.title = @"我的";
    mvc.tabBarItem.image = [UIImage imageNamed:@"我的_默认"];
    mvc.tabBarItem.selectedImage = [UIImage imageNamed:@"我的_焦点"];
    
    
    self.viewControllers = @[[[MainNavigationViewController alloc]initWithRootViewController:hvc],[[MainNavigationViewController alloc]initWithRootViewController:cvc],[[MainNavigationViewController alloc]initWithRootViewController:lvc],[[MainNavigationViewController alloc]initWithRootViewController:mvc]];
    
    self.tabBar.tintColor = MainColor;
 
    
}

//询问是否支持旋转
- (BOOL)shouldAutorotate
{
    //    获取导航控制器 是否支持
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}

@end
