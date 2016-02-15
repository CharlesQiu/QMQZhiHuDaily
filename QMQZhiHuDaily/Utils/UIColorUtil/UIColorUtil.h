//
//  UIColorUtils.h
//  QMQZhiHuDaily
//
//  Created by Charles on 1/27/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    /// 把16进制字符串转为UIcolor
    UIColor *hexString(NSString *hexString);
    
    /// rgba颜色
    UIColor *hexRGBA(NSInteger red, NSInteger green, NSInteger blue, NSInteger alpha);
#ifdef __cplusplus
}
#endif
