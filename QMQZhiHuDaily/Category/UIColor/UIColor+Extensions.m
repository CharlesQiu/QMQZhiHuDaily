//
//  UIColor+Extensions.m
//
//  Created by Charles on 3/12/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    if (!hexString || [hexString length] == 0) {
        return nil;
    }
    
    NSString *rgb = nil;
    
    if ([hexString characterAtIndex:0] == '#') {
        rgb = [[hexString substringFromIndex:1] lowercaseString];
    } else {
        rgb = [hexString lowercaseString];
    }
    
    if ([rgb length] != 6) {
        return nil;
    }
    
    CGFloat r = strtol([[rgb substringWithRange:NSMakeRange(0, 2)] cStringUsingEncoding:NSUTF8StringEncoding], NULL, 16);
    CGFloat g = strtol([[rgb substringWithRange:NSMakeRange(2, 2)] cStringUsingEncoding:NSUTF8StringEncoding], NULL, 16);
    CGFloat b = strtol([[rgb substringWithRange:NSMakeRange(4, 2)] cStringUsingEncoding:NSUTF8StringEncoding], NULL, 16);
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

@end
