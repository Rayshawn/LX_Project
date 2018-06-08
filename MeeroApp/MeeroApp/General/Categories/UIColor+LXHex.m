//
//  UIColor+LXHex.m
//  MeeroApp
//
//  Created by shawn on 2018/6/5.
//  Copyright © 2018年 Technology Co., Ltd.meero. All rights reserved.
//

#import "UIColor+LXHex.h"

@implementation UIColor (LXHex)
+ (UIColor *)LX_colorWithHexStr:(NSString *)hexStr {
    return [self LX_colorWithHexStr:hexStr alpha:1];
}
+ (UIColor *)LX_colorWithHexStr:(NSString *)hexStr alpha:(float)alpha {
    if (!hexStr || hexStr.length != 6) {
        return [UIColor grayColor];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [hexStr substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [hexStr substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [hexStr substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    if (alpha == 0) {
        alpha = 1;
    }
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end
