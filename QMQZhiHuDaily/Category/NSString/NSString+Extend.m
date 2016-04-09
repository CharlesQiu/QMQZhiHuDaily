//
//  NSString+Extend.m
//
//  Created by Charles on 4/9/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)

+ (BOOL)isEmptyString:(NSString *)string {
    NSString *temp = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return [temp length] == 0;
}

@end
