//
//  TabBarController.m
//  MeeroApp
//
//  Created by shawn on 2018/5/30.
//  Copyright © 2018年 Technology Co., Ltd.meero. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "LXMyMeeroVC.h"
#import "LXKernelVC.h"
#import "LXRecommendVC.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype)init {
    if (self = [super init]) {
        NavigationController *navMe = [[NavigationController alloc] initWithRootViewController:[[LXMyMeeroVC alloc] init]];
        NavigationController *navKer = [[NavigationController alloc] initWithRootViewController:[[LXKernelVC alloc] init]];
        NavigationController *navRe = [[NavigationController alloc] initWithRootViewController:[[LXRecommendVC alloc] init]];
        
        navMe.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:nil selectedImage:nil];
        navKer.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"拍摄" image:nil selectedImage:nil];
        navRe.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推荐" image:nil selectedImage:nil];
        [self.tabBar setBackgroundImage:[UIImage new]];
        [self.tabBar setShadowImage:[UIImage new]];
        self.viewControllers = @[navMe,navKer,navRe];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
