//
//  QMQUIImageUtils.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/29/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQUIImageUtils.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

UIImage *iconWithInfo(NSString *string, UIColor *color, NSString *fontName, CGFloat fontSize) {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat realSize = fontSize * scale;
    UIFont *font = [UIFont fontWithName:fontName size:realSize];
    
    UIGraphicsBeginImageContext(CGSizeMake(realSize, realSize));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if ([string respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
        [string drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName: font,
                                                         NSForegroundColorAttributeName: color}];
    } else {
        CGContextSetFillColorWithColor(context, color.CGColor);
        [string drawAtPoint:CGPointZero withFont:font];
    }
    
    UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma clang diagnostic pop

//+ (UIImage *)iconWithInfo:(TBCityIconInfo *)info {
//    CGFloat size = info.size;
//    CGFloat scale = [UIScreen mainScreen].scale;
//    CGFloat realSize = size * scale;
//    UIFont *font = [TBCityIconFontUtil fontWithSize:realSize];
//    UIGraphicsBeginImageContext(CGSizeMake(realSize, realSize));
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    if ([info.text respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
//        [info.text drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName: info.color}];
//    } else {
//        CGContextSetFillColorWithColor(context, info.color.CGColor);
//        [info.text drawAtPoint:CGPointMake(0, 0) withFont:font];
//    }
//    
//    UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
//    UIGraphicsEndImageContext();
//    
//    return image;
//}
