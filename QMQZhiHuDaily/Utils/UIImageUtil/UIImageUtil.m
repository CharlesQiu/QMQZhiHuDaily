//
//  QMQUIImageUtils.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/29/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "UIImageUtil.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

UIImage *iconWithInfo(NSString *string, UIColor *color, NSString *fontName, CGFloat fontSize) {
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:fontName
                                 size:fontSize];
    label.text      = string;
    label.textColor = color;
    [label sizeToFit];
    
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, NO, 0.0);
    [[label layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

UIImage *icomoonImage(NSString *code, UIColor *color, CGFloat fontSize) {
    return iconWithInfo(code, color, @"icomoon", fontSize);
}

UIImage *imageWithColor(UIColor *color) {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma clang diagnostic pop
