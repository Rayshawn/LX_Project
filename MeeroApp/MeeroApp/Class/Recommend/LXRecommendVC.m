//
//  LXRecommendVC.m
//  MeeroApp
//
//  Created by shawn on 2018/5/30.
//  Copyright © 2018年 Technology Co., Ltd.meero. All rights reserved.
//

#import "LXRecommendVC.h"

@interface LXRecommendVC ()

@end

@implementation LXRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐";
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
