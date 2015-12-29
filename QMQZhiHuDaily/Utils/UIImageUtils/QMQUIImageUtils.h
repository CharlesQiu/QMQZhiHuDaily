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
    
    /// iconFont转图片
    UIImage *iconWithInfo(NSString *string, UIColor *color, CGFloat fontSize);
    
#ifdef __cplusplus
}
#endif
