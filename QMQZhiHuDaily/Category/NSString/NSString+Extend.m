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

+ (NSString *)toHex:(NSInteger)decimalNum {
    NSString   *nLetterValue = @"";
    NSString   *str          = @"";
    NSUInteger ttmpig        = 0;
    for (int i = 0; i < 9; i++) {
        ttmpig     = decimalNum % 16;
        decimalNum = decimalNum / 16;
        switch (ttmpig) {
            case 10:
                nLetterValue = @"A"; break;
            case 11:
                nLetterValue = @"B"; break;
            case 12:
                nLetterValue = @"C"; break;
            case 13:
                nLetterValue = @"D"; break;
            case 14:
                nLetterValue = @"E"; break;
            case 15:
                nLetterValue      = @"F"; break;
            default: nLetterValue = [[NSString alloc]initWithFormat:@"%lu", (unsigned long)ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (decimalNum == 0) {
            break;
        }
    }
    return str;
}

@end
