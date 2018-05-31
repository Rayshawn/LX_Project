//
//  LXMyMeeroVC.m
//  MeeroApp
//
//  Created by shawn on 2018/5/30.
//  Copyright © 2018年 Technology Co., Ltd.meero. All rights reserved.
//

#import "LXMyMeeroVC.h"
#import "LXRecommendVC.h"
@interface LXMyMeeroVC ()

@end

@implementation LXMyMeeroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Meero";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [redView addGestureRecognizer:tap];
}

- (void)tapClick {
    [self.navigationController pushViewController:[[LXRecommendVC alloc] init] animated:YES];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.navigationController pushViewController:[[LXMyMeeroVC alloc] init] animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
