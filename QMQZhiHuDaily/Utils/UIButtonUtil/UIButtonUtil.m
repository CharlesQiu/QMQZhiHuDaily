//
//  UIButtonUtil.m
//  QMQZhiHuDaily
//
//  Created by Charles on 1/27/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "UIButtonUtil.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

UIButton *createNormalImageButton(UIImage *normalImage, UIImage *disabledImage, id target, SEL selector) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:disabledImage forState:UIControlStateDisabled];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    return button;
}

#pragma clang diagnostic pop
