//
//  LXMyMeeroVC.m
//  MeeroApp
//
//  Created by shawn on 2018/5/30.
//  Copyright © 2018年 Technology Co., Ltd.meero. All rights reserved.
//

#import "LXMyMeeroVC.h"
#import "LXRecommendVC.h"
#import "LXLoadingView.h"
@interface LXMyMeeroVC ()
//@property (nonatomic, strong) LXLoadingLayer * loadingLayer;
@property (nonatomic, strong) LXLoadingView * loadingView;

@end

@implementation LXMyMeeroVC

- (void)addCircleLayer {
    self.loadingView = [[LXLoadingView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:self.loadingView];
    
//    self.loadingLayer = [[LXLoadingLayer alloc] init];
//    [self.loadingLayer setFrame:CGRectMake(100, 200, 100, 100)];
//    self.loadingLayer.progress = 1;
//    [self.view.layer addSublayer:self.loadingLayer];
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
//    animation.duration = 3;
//    animation.fromValue = @(0);
//    animation.toValue = @(1);
//    [self.loadingLayer addAnimation:animation forKey:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Meero";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [redView addGestureRecognizer:tap];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(200, 0, 80, 80)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    UITapGestureRecognizer *blueTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBlueClick)];
    [blueView addGestureRecognizer:blueTap];
}

- (void)tapBlueClick {
    [self addCircleLayer];
    [self.loadingView startFail];
}

- (void)tapClick {
    [self addCircleLayer];
    [self.loadingView startSuccess];
//    [self.navigationController pushViewController:[[LXRecommendVC alloc] init] animated:YES];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.navigationController pushViewController:[[LXMyMeeroVC alloc] init] animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
