//
//  QMQUIImageUtils.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/29/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "UIImageUtil.h"

@implementation UIImageUtil

+ (UIImage *)iconWithFontName:(NSString *)fontName
                         code:(NSString *)code
                        color:(UIColor *)color
                     fontSize:(CGFloat)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:fontName
                                 size:fontSize];
    label.text      = code;
    label.textColor = color;
    [label sizeToFit];
    
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, NO, 0.0);
    [[label layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithIconFontCode:(NSString *)code
                             color:(UIColor *)color
                          fontSize:(CGFloat)fontSize {
    return [self iconWithFontName:@"icomoon"
                             code:code color:color
                         fontSize:fontSize];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
