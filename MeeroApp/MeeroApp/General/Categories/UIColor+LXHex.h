//
//  UIColor+LXHex.h
//  MeeroApp
//
//  Created by shawn on 2018/6/5.
//  Copyright © 2018年 Technology Co., Ltd.meero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LXHex)

/**
 16进制的颜色转换
 @param hexStr 色值 @"FFFFFF"
 @return 返回颜色对象 默认值为 grayColor
 */
+ (UIColor *)LX_colorWithHexStr:(NSString *)hexStr;

/**
 16进制的颜色转换  @"FFFFFF"

 @param hexStr 色值
 @param alpha 透明度
 @return 颜色对象 默认值为 grayColor
 */
+ (UIColor *)LX_colorWithHexStr:(NSString *)hexStr alpha:(float)alpha;

@end
