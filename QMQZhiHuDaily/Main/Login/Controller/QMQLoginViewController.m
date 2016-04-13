//
//  QMQLoginViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/11/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLoginViewController.h"
#import "QMQUserCenterViewController.h"
#import "QMQLoginManager.h"
#import "QMQAccountInfo.h"
#import "OpenShareHeader.h"

@interface QMQLoginViewController ()

@property (nonatomic, strong) UIButton *qqButton;
@property (nonatomic, strong) UIButton *weixinButton;
@property (nonatomic, strong) UIButton *weiboButton;

@end

/// 按钮大小
static CGFloat const kButtonSize = 100.0;
/// 按钮间距
static CGFloat const kButtonSpacing = 30.0;

@implementation QMQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    
    UIImage *normalImage = [UIImageUtil imageWithIconFontCode:QMQIconCross
                                                        color:[UIColor whiteColor]
                                                     fontSize:QMQNavigationBarIconSize];
    UIImage *disableImage = [UIImageUtil imageWithIconFontCode:QMQIconCross
                                                         color:[UIColor grayColor]
                                                      fontSize:QMQNavigationBarIconSize];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:normalImage
            forState:UIControlStateNormal];
    [button setImage:disableImage
            forState:UIControlStateDisabled];
    [button sizeToFit];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *button) {
         @strongify(self);
         [self dismissViewControllerAnimated:YES completion:nil];
     }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    // QQ按钮
    UIImage *qqImage = [UIImageUtil imageWithIconFontCode:QMQIconQQ
                                                    color:[UIColor colorWithHexString:QMQStyleColor]
                                                 fontSize:kButtonSize];
    self.qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.qqButton setImage:qqImage forState:UIControlStateNormal];
    [[self.qqButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [[QMQLoginManager shareInstance] loginWithTencentQQSuccess:^(QMQAccountInfo *accountInfo) {
            @strongify(self);
            
            QMQUserCenterViewController *userCenterVC = [[QMQUserCenterViewController alloc] init];
            userCenterVC.accountInfo = accountInfo;
            [self.navigationController pushViewController:userCenterVC animated:YES];
        } failure:^(NSString *failureMsg) {
            
        }];
    }];
    [self.view addSubview:self.qqButton];
    
    // 微信按钮
    UIImage *weixinImage = [UIImageUtil imageWithIconFontCode:QMQIconWeixin
                                                        color:[UIColor colorWithHexString:QMQStyleColor]
                                                     fontSize:kButtonSize];
    self.weixinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.weixinButton setImage:weixinImage forState:UIControlStateNormal];
    [[self.weixinButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [[QMQLoginManager shareInstance] loginWithWeiXinSuccess:^(QMQAccountInfo *accountInfo) {
            @strongify(self);
            
            QMQUserCenterViewController *userCenterVC = [[QMQUserCenterViewController alloc] init];
            userCenterVC.accountInfo = accountInfo;
            [self.navigationController pushViewController:userCenterVC animated:YES];
        } failure:^(NSString *failureMsg) {
            
        }];
        
    }];
    [self.view addSubview:self.weixinButton];
    
    // 微博按钮
    UIImage *weiboImage = [UIImageUtil imageWithIconFontCode:QMQIconWeibo
                                                       color:[UIColor colorWithHexString:QMQStyleColor]
                                                    fontSize:kButtonSize];
    self.weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.weiboButton setImage:weiboImage forState:UIControlStateNormal];
    [[self.weiboButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [[QMQLoginManager shareInstance] loginWithWeiBoSuccess:^(QMQAccountInfo *accountInfo) {
            @strongify(self);
            
            QMQUserCenterViewController *userCenterVC = [[QMQUserCenterViewController alloc] init];
            userCenterVC.accountInfo = accountInfo;
            [self.navigationController pushViewController:userCenterVC animated:YES];
        } failure:^(NSString *failureMsg) {
            
        }];

    }];
    [self.view addSubview:self.weiboButton];
    
    self.qqButton.hidden     = ![OpenShare isQQInstalled];
    self.weixinButton.hidden = YES;
    self.weiboButton.hidden  = YES;
    
    [self.qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.equalTo(self.view);
//        make.bottom.equalTo(self.mas_topLayoutGuideBottom);
    }];
    [self.weixinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.qqButton.mas_bottom).offset(kButtonSpacing).priorityLow();
    }];
    [self.weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.weixinButton.mas_bottom).offset(kButtonSpacing);
    }];
    
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:YES initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)updateViewConstraints {
    @weakify(self);
    [self.qqButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.equalTo(self.view);
//        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(15.0);
    }];
    
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
