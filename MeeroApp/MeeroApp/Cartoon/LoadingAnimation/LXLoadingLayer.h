//
//  LXLoadingLayer.h
//  MeeroApp
//
//  Created by shawn on 2018/6/4.
//  Copyright © 2018年 Technology Co., Ltd.meero. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface LXLoadingLayer : CALayer
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) UIColor * color;
@property (nonatomic, assign) CGFloat lineWidth;

@end
