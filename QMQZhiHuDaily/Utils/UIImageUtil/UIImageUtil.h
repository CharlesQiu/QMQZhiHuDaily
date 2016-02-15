//
//  QMQUIImageUtils.h
//  QMQZhiHuDaily
//
//  Created by Charles on 12/29/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    /// icomoon的iconfont
    UIImage *icomoonImage(NSString *code, UIColor *color, CGFloat fontSize);
    
    /// 颜色图片
    UIImage *imageWithColor(UIColor *color);
#ifdef __cplusplus
}
#endif
