//
//  UIColorUtils.m
//  QMQZhiHuDaily
//
//  Created by Charles on 1/27/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "UIColorUtil.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

UIColor *hexString(NSString *hexString) {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length   = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:1.0f];
}

UIColor *hexRGBA(NSInteger red, NSInteger green, NSInteger blue, NSInteger alpha) {
    return [UIColor colorWithRed:(float)red / 255.0f
                           green:(float)green / 255.0f
                            blue:(float)blue / 255.0f
                           alpha:(float)alpha / 255.0f];
}

#pragma clang diagnostic pop
