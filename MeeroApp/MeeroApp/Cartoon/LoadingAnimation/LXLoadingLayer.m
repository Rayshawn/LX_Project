//
//  LXLoadingLayer.m
//  MeeroApp
//
//  Created by shawn on 2018/6/4.
//  Copyright © 2018年 Technology Co., Ltd.meero. All rights reserved.
//

#import "LXLoadingLayer.h"


@implementation LXLoadingLayer
@dynamic progress;
@dynamic color;
@dynamic lineWidth;
//- (void)display {
//    NSLog(@">>>>>>%f",[self presentationLayer].progress);
//}
+ (BOOL)needsDisplayForKey:(NSString *)key {// 检测值的变化，返回yes调取drawInContext:或者 display 方法，当CALayer实现该方法，并且 key 被检测时 key 的属性必须@dynamic
    if ([key isEqualToString:@"progress"]) {
        return YES;
    } else if ([key isEqualToString:@"color"]) {
        return YES;
    } else if ([key isEqualToString:@"lineWidth"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx {// 方法中动画中取的值 self.progress 为过程值  即[self presentationLayer].progress  display中取的self.progress值为最终值
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2 - self.lineWidth/2;
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    // O
    CGFloat originStart = M_PI * 7 / 2;
    CGFloat originEnd = M_PI * 2;
    CGFloat currentOrigin = originStart - (originStart - originEnd) * self.progress;
//    NSLog(@">>>>>>%f",[self presentationLayer].progress);
    // D
    CGFloat destStart = M_PI * 3;
    CGFloat destEnd = 0;
    CGFloat currentDest = destStart - (destStart - destEnd) * self.progress;
    
    [path addArcWithCenter:center radius:radius startAngle:currentOrigin endAngle:currentDest clockwise:NO];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextSetStrokeColorWithColor(ctx, self.color.CGColor);
    CGContextStrokePath(ctx);
}

@end
