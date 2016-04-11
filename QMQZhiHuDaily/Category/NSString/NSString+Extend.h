//
//  NSString+Extend.h
//
//  Created by Charles on 4/9/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

/**
 *  判断是否空字符串
 */
+ (BOOL)isEmptyString:(NSString *)string;

/**
 *  十进制转十六进制
 */
+ (NSString *)toHex:(NSInteger)decimalNum;
@end
