//
//  QMQSpinner.m
//  QMQZhiHuDaily
//
//  Created by Charles on 6/5/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQSpinner.h"
#import <MBProgressHUD.h>

#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width

@interface QMQSpinner () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIView *hudAddedView;

@end

static NSString *const kLoadingMessage = @"加载中...";
static CGFloat const   kShowTime       = 2.0f;
static QMQSpinner      *_sharedSpinner = nil;

@implementation QMQSpinner

#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        self.isShowGloomy = YES;
    }
    return self;
}

#pragma mark - Lazy Load
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha           = 0.5;
        _bottomView.hidden          = YES;
    }
    return _bottomView;
}

#pragma mark - 单例
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSpinner = [[self alloc] init];
    });
    return _sharedSpinner;
}

#pragma mark - 简短提示语
+ (void)showBriefMessage:(NSString *)message InView:(UIView *)view {
    _sharedSpinner.hudAddedView = view;
    [self shareManager];
    if (view == nil) {
        view = [[UIApplication sharedApplication] windows].lastObject;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.mode      = MBProgressHUDModeText;
    hud.margin    = 10.f;
    //HUD.yOffset = 200;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:kShowTime];
    [_sharedSpinner addGestureInView:view];
}

#pragma mark - 长时间的提示语
+ (void)showPermanentMessage:(NSString *)message InView:(UIView *)view {
    _sharedSpinner.hudAddedView = view;
    [self shareManager];
    if (view == nil) {
        view = [[UIApplication sharedApplication] windows].lastObject;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText                 = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode                      = MBProgressHUDModeCustomView;
    if (_sharedSpinner.isShowGloomy) {
        //如果添加了view则将botomView的frame修改与view一样大
        if (_sharedSpinner.hudAddedView) {
            _sharedSpinner.bottomView.frame = CGRectMake(0, 0, _sharedSpinner.hudAddedView.frame.size.width, _sharedSpinner.hudAddedView.frame.size.height);
        }
        [view addSubview:_sharedSpinner.bottomView];
        [_sharedSpinner showBackView];
    }
    [view bringSubviewToFront:hud];
    [_sharedSpinner addGestureInView:view];
}

#pragma mark - 网络加载提示用
+ (void)showLoadingInView:(UIView *)view {
    _sharedSpinner.hudAddedView = view;
    [self shareManager];
    if (view == nil) {
        view = [[UIApplication sharedApplication] windows].lastObject;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.labelText                 = kLoadingMessage;
    hud.removeFromSuperViewOnHide = YES;
    if (_sharedSpinner.isShowGloomy) {
        //如果添加了view则将botomView的frame修改与view一样大
        if (_sharedSpinner.hudAddedView) {
            _sharedSpinner.bottomView.frame = CGRectMake(0, 0, _sharedSpinner.hudAddedView.frame.size.width, _sharedSpinner.hudAddedView.frame.size.height);
        }
        [view addSubview:_sharedSpinner.bottomView];
        [_sharedSpinner showBackView];
    }
    [view addSubview:hud];
    [hud show:YES];
    [_sharedSpinner addGestureInView:view];
}

+ (void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title inView:(UIView *)view {
    _sharedSpinner.hudAddedView = view;
    [self shareManager];
    if (view == nil) {
        view = [[UIApplication sharedApplication]windows].lastObject;
    }
    MBProgressHUD *hud        = [MBProgressHUD showHUDAddedTo:view animated:YES];
    UIImageView   *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
    littleView.image              = [UIImage imageNamed:imageName];
    hud.customView                = littleView;
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType             = MBProgressHUDAnimationZoom;
    hud.labelText                 = title;
    hud.mode                      = MBProgressHUDModeCustomView;
    [hud show:YES];
    [hud hide:YES afterDelay:kShowTime];
    [_sharedSpinner addGestureInView:view];
}

#pragma mark - 外部调用
+ (void)showLoading {
    [self showLoadingInView:nil];
}

+ (void)showBriefAlert:(NSString *)alert {
    [self showBriefMessage:alert InView:nil];
}

+ (void)showPermanentAlert:(NSString *)alert {
    [self showPermanentMessage:alert InView:nil];
}

//+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title{
//    [self showAlertWithCustomImage:imageName title:title inView:nil];
//}
#pragma mark - 隐藏提示框
+ (void)hideAlert {
    [_sharedSpinner hideBackView];
    UIView *view;
    if (_sharedSpinner.hudAddedView) {
        view = _sharedSpinner.hudAddedView;
    } else {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view];
}

+ (void)hideHUDForView:(UIView *)view {
    [self hideHUDForView:view animated:YES];
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [self HUDForView:view];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:animated];
        return YES;
    }
    return NO;
}

+ (MBProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}

#pragma mark - 深色背景
- (void)showBackView {
    self.bottomView.hidden = NO;
}

- (void)hideBackView {
    self.bottomView.hidden = YES;
    [self.tap removeTarget:nil action:nil];
    self.bottomView.frame = CGRectMake(0, 0, kScreen_width, kScreen_height);
}

#pragma mark - 添加手势,触摸屏幕将提示框隐藏
- (void)addGestureInView:(UIView *)view {
    self.tap          = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheScreen)];
    self.tap.delegate = self;
    [view addGestureRecognizer:self.tap];
    
}

#pragma mark -点击屏幕
- (void)tapTheScreen {
    NSLog(@"点击屏幕");
    [_sharedSpinner hideBackView];
    [self.tap removeTarget:nil action:nil];
    [QMQSpinner hideAlert];
}

#pragma mark - 解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[MBProgressHUD class]]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

@end
