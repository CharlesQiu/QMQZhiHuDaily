//
//  UIViewController+Swizzling.m
//
//  Created by Charles on 3/12/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(viewDidLoad) withSelector:@selector(mainpageViewDidLoad)];
#ifdef DEBUG
        [self swizzleSelector:@selector(viewWillAppear:) withSelector:@selector(logWhenViewWillAppear:)];
#endif
    });
}

+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod,
                                       swizzledMethod);
    }
}

- (void)logWhenViewWillAppear:(BOOL)animated {
    [self logWhenViewWillAppear:animated];
    
    NSString *className = NSStringFromClass([self class]);
    
    if ([className hasPrefix:@"UI"]) {
        // Do not log system UI view controllers
        return;
    }
    LOGDEBUG(([NSString stringWithFormat:@"%@ will appear", className]));
}

/**
 *  统一修改主页几个viewcontroller的导航栏设置
 */
- (void)mainpageViewDidLoad {
    [self mainpageViewDidLoad];
    
    BOOL isSwizzling =
    [NSStringFromClass([self class]) isEqualToString:@"QMQHotNewsViewController"]
    || [NSStringFromClass([self class]) isEqualToString:@"QMQLatestNewsViewController"]
    || [NSStringFromClass([self class]) isEqualToString:@"QMQColumnViewController"]
    || [NSStringFromClass([self class]) isEqualToString:@"QMQThemeViewController"]
    || [NSStringFromClass([self class]) isEqualToString:@"QMQHistoryNewsViewController"]
    || [NSStringFromClass([self class]) isEqualToString:@"QMQLoginViewController"]
    || [NSStringFromClass([self class]) isEqualToString:@"QMQUserCenterViewController"];
    
    if (!isSwizzling) {
        return;
    }
    
    self.view.backgroundColor                                   = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor        = [UIColor colorWithHexString:QMQStyleColor];
    self.navigationController.navigationBar.barStyle            = UIBarStyleBlack;
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:FONT_DEFAULT_LIGHT size:20.0f]};
}

@end
