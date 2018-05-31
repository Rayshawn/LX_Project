//
//  NavigationController.m
//  MeeroApp
//
//  Created by shawn on 2018/5/30.
//  Copyright © 2018年 Technology Co., Ltd.meero. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationBar.backIndicatorImage = [UIImage imageNamed:@"blue-pitch"];
    self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"blue-pitch"];
//    self.navigationBar.tintColor = [UIColor grayColor];
}
- (void)backItemAction {
    NSLog(@"返回按钮的点击");
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    NSLog(@"====%@",viewController);
    
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:nil action:nil];
//    if (self.viewControllers.count != 0) {
////        self.navigationBar.prefersLargeTitles
//        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:nil action:nil];
//    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
