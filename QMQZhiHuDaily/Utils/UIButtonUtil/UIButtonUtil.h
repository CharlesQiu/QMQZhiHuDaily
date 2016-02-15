//
//  UIButtonUtil.h
//  QMQZhiHuDaily
//
//  Created by Charles on 1/27/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    /// 创建普通的按钮
    UIButton *createNormalImageButton(UIImage *normalImage, UIImage *disabledImage, id target, SEL selector);
    
#ifdef __cplusplus
}
#endif
